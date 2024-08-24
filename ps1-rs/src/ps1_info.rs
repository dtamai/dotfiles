use std::path::{Path, PathBuf};
use std::process::Command;
use std::{env, fs};

use time::macros::format_description;
use time::OffsetDateTime;

const FG_RESET: &str = "\x1b[0;0m";
const FG_RED: &str = "\x1b[31m";
const FG_GREEN: &str = "\x1b[32m";
const FG_YELLOW: &str = "\x1b[33m";
const FG_BLUE: &str = "\x1b[34;1m";
const FG_MAGENTA: &str = "\x1b[35m";
const FG_CYAN: &str = "\x1b[36m";
const FG_WHITE: &str = "\x1b[37m";

const SUPERSCRIPTS: [&str; 10] = ["⁰", "¹", "²", "³", "⁴", "⁵", "⁶", "⁷", "⁸", "⁹"];

fn time() -> String {
    let color = FG_CYAN;

    let format = format_description!("[hour]:[minute]:[second]");
    let now = OffsetDateTime::now_local().unwrap();
    let now = now.format(format).unwrap();

    format!("{color}{now}")
}

fn current_dir() -> String {
    let color = FG_YELLOW;

    let home = match home::home_dir() {
        Some(path) => path.display().to_string(),
        None => "???".to_string(),
    };

    let current_dir = match env::current_dir() {
        Ok(path) => path.display().to_string(),
        Err(_) => "???".to_string(),
    };

    let current_dir = current_dir.replacen(&home, "~", 1);

    format!("{color}{current_dir}")
}

fn git_dir() -> Option<PathBuf> {
    let current_dir_res = env::current_dir();
    if matches!(current_dir_res, Err(_)) {
        return None;
    }

    let current_dir = current_dir_res.unwrap();
    let mut ancestors = current_dir.ancestors();

    loop {
        match ancestors.next() {
            None => break None,
            Some(path) => {
                let git_path = path.join(".git");
                if git_path.is_dir() {
                    break Some(git_path);
                }

                if git_path.is_file() {
                    match std::fs::read_to_string(git_path) {
                        Err(_) => break None,
                        Ok(contents) => {
                            if let Some((_, git_dir)) = contents.split_once("gitdir: ") {
                                break Some(PathBuf::from(git_dir.trim()));
                            }
                        }
                    }
                }
            }
        };
    }
}

fn git_stash_count(git_dir: &Path) -> String {
    let stash_refs = fs::read(git_dir.join("logs/refs/stash"));
    if matches!(stash_refs, Err(_)) {
        return String::new();
    }
    let stash_refs = stash_refs.unwrap();

    let count = stash_refs.iter().filter(|&byte| byte == &b'\n').count();
    if count > 9 {
        return "⁹⁺".to_string();
    }

    SUPERSCRIPTS[count].to_string()
}

fn git_branch(git_dir: &Path) -> String {
    let head = fs::read(git_dir.join("HEAD"));
    if matches!(head, Err(_)) {
        return String::new();
    }
    let head = head.unwrap();

    let (prefix, branch) = head.split_at(16);
    let git_ref = std::str::from_utf8(branch);
    if matches!(git_ref, Err(_)) {
        return String::new();
    }
    let git_ref = git_ref.unwrap().trim_end();

    let (color, branch) = if prefix == b"ref: refs/heads/" {
        if git_ref == "main" || git_ref == "master" {
            (FG_MAGENTA, "𝓶")
        } else {
            (FG_BLUE, git_ref)
        }
    } else {
        let commit = &git_ref[0..=8];
        (FG_BLUE, commit)
    };

    format!("{color}{branch}{FG_RESET}")
}

fn git_status(_git_dir: &Path) -> String {
    let output = Command::new("git").args(["status", "--porcelain"]).output();
    if matches!(output, Err(_)) {
        return String::new();
    }
    let output = output.unwrap();

    let (color, icon) = if !output.stdout.is_empty() {
        (FG_RED, "-")
    } else {
        (FG_GREEN, ".")
    };

    format!("{color}{icon}")
}

fn git_info() -> String {
    let git_dir = git_dir();
    if git_dir.is_none() {
        return String::new();
    }
    let git_dir = git_dir.unwrap();

    let stash_count = git_stash_count(&git_dir);
    let branch = git_branch(&git_dir);
    let status = git_status(&git_dir);

    format!("{FG_WHITE}{stash_count}{branch} {status}")
}

pub fn ps1_info() -> String {
    let time = time();
    let current_dir = current_dir();
    let git_info = git_info();

    format!("{time} {current_dir} {git_info}{FG_RESET}")
}
