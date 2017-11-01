function util::error(String $message, Integer $exitcode=1) {
  util::print($message)
  util::exit($exitcode)
}
