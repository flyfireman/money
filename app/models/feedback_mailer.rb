class FeedbackMailer < ActionMailer::Base
  
  def feedback(feedback)
    @recipients  = 'yangxiwenhuai@gmail.com'
    @from        = 'flyfireman@163.com'
    @subject     = "[Feedback for YourSite] #{feedback.subject}"
    @sent_on     = Time.now
    @body[:feedback] = feedback    
  end

end
