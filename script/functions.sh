function is_ruby_23_plus {
  if ruby -e "exit(RUBY_VERSION.to_f >= 2.3)"; then
    return 0
  else
    return 1
  fi
}
