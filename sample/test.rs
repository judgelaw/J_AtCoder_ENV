use proconio::input;
use std::collections::VecDeque;

// AWC0001-E問題
// https://atcoder.jp/contests/awc0001/tasks/awc0001_e

// geminiさんにpythonコードから変換してもらい作成

// 共通ロジック：比較関数 `f` を受け取ってスライド窓処理を行う
fn slide_window_op<F>(a: &[i64], k: usize, f: F) -> Vec<i64>
where
    F: Fn(i64, i64) -> bool, // 2つの値を比較して bool を返す関数（クロージャ）
{
    let mut q: VecDeque<usize> = VecDeque::new();

    (0..a.len()).map(|i| {
        // ウィンドウ外の要素を削除
        if i >= k && q.front() == Some(&(i - k)) {
            q.pop_front();
        }
        // 比較関数 `f` に基づいて不要な要素を削除
        while let Some(&back) = q.back() {
            if f(a[back], a[i]) {
                q.pop_back();
            } else {
                break;
            }
        }
        q.push_back(i);
        a[*q.front().unwrap()]
    }).collect()
}

// 最小値を求める：既存の要素が新しい要素より「大きい」場合に削除
fn slide_minimum(a: &[i64], k: usize) -> Vec<i64> {
    slide_window_op(a, k, |back, new| back > new)
}

// 最大値を求める：既存の要素が新しい要素より「小さい」場合に削除
fn slide_maximum(a: &[i64], k: usize) -> Vec<i64> {
    slide_window_op(a, k, |back, new| back < new)
}

fn main() {
    input! {
        n: usize,
        k: usize,
        h: [i64; n],
    }

    let th = slide_maximum(&h, k);
    let tl = slide_minimum(&h, k);

    let res = (0..n)
        .map(|i| th[i] - tl[i])
        .max()
        .unwrap_or(0);

    println!("{}", res);
}