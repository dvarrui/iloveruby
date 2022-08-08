fn main() {
    let xs = (1..=10)
        .map(|a| {
            (1..=10).map(|b| {
                if a > b {
                    String::from("    ")
                } else {
                    format!("{:4}", a * b)
                }
            }).collect::<String>()
        }).collect::<Vec<String>>();

    println!("{}", xs.join("\n"))
}
