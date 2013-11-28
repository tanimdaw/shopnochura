class FetchJobs
	
	require 'mechanize'

	def starting
		agent = Mechanize.new
		page = agent.get('http://jobs.bdjobs.com/jobsbycategory.asp?cat=1')

		
		# $("a#btn-close").click();

		links = agent.page.links_with(:href => /^JobDetails.asp/)
		link = links[0]
		job_details_page = link.click
		posting_date = job_details_page.search("td.BDJValues").text
		# text = job_details_page.search("td.BDJValues").text
		posting_content = posting_date.split("Posting Date:")[1]
		only_content = posting_content.gsub(/\s+/, "")
		only_content = only_content.gsub(/]/, "")
		DateTime.strptime('November14,2013', '%B%d,%Y')

		real_post_date_obj = Date.strptime(only_content, '%B%d,%Y')




		company_name = job_details_page.search("span.BDJtabLinkSelected").text
		company_name = company_name.gsub(/\r\n/, "").strip

		post_name = job_details_page.search("td#tdcornertl span.BDJFormTitle").text.strip

		vacancy_text = job_details_page.search("table.body td:first-child").text.gsub(/\t/, "").gsub(/\r\n/, "").strip

		vt = vacancy_text.split("No. of Vacancies :")[1]


		td = job_details_page.search("td.body")

		# November14,2013


		
		# text =~ /(?<=Posting Date:).*/
		puts "============================"
		puts page.inspect 
	end



	def get_job_details_content
		agent = Mechanize.new
		page = agent.get('http://jobs.bdjobs.com/jobsbycategory.asp?cat=1')
		links = agent.page.links_with(:href => /^JobDetails.asp/)
		link = links[0]
		job_details_page = link.click
		td = job_details_page.search("td.body")		
		response = ""
		h = Hash.new 
		last_key = nil
		td.children.each do |child|   
			if child.attr("class") == "BDJtabNormal"
					response += child.text.strip
					last_key = child.text.strip
					h[last_key] = []
			elsif last_key.present?
				# h[last_key] << child.text.strip unless child.comment?
				child_content_array = get_all_content_as_array(child)

				h[last_key] << child_content_array unless child.comment?
			end
		end
		h.each do |key, value|
			h[key] = value.flatten
		end
		return h
	end

	def get_all_content_as_array(child)
		result_array = []
		if child.children.size > 0
			child.children.each do |single_child|
				res = get_all_content_as_array(single_child)
				# res.gsub(/\r/,"").gsub(/\n/,"").gsub(/\t/,"").strip unless res.kind_of?(Array)
				result_array << res
			end
		else
			result_array << child.content unless child.comment?		
		end
		result_array = result_array.flatten
		result_array.collect! do |single_element|
			single_element.gsub(/\r/,"").gsub(/\n/,"").gsub(/\t/,"").gsub(/[[:space:]]/, ' ').strip
		end
		result_array.reject! { |c| c.empty? }
		return result_array
	end	



end