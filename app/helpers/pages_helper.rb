module PagesHelper
  def select_hour(datetime, options = {}, html_options = {})
    val = datetime ? (datetime.kind_of?(Fixnum) ? datetime : datetime.hour) : ''
    if options[:use_hidden]
      hidden_html(options[:field_name] || 'hour', val, options)
    else
      ampm = ["12pm", "1am", "2am", "3am", "4am", "5am", "6am", "7am", "8am", "9am", "10am", "11am", "12pm", "1pm", "2pm", "3pm", "4pm", "5pm", "6pm", "7pm", "8pm", "9pm", "10pm", "11pm"]
      hour_options = []
      0.upto(23) do |hour|
        hour_options << ((val == hour) ?
          content_tag(:option, ampm[hour], :value => leading_zero_on_single_digits(hour), :selected => "selected") :
          content_tag(:option, ampm[hour], :value => leading_zero_on_single_digits(hour))
        )
        hour_options << "\n"
      end
      select_html(options[:field_name] || 'hour', hour_options.join, options, html_options)
    end
  end
  
end
