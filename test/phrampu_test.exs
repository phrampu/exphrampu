ExUnit.start

defmodule PhrampuTest do
  use ExUnit.Case, async: true

  test "who struct 1" do
    x = WhoStruct.from_string("azehady  tty7    Thu18   37:00m  5.35s  5.29s vim system/resched.c")
    assert x.user == "azehady"
    assert x.tty  == "tty7"
    assert x.login == "Thu18"
    assert x.idle == "37:00m"
    assert x.jcpu == "5.35s"
    assert x.pcpu == "5.29s"
    assert x.what == "vim system/resched.c"
    assert WhoModule.istty(x.tty)
  end
end
