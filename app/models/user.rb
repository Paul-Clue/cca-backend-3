class User < ApplicationRecord
  has_many :posts
  has_secure_password

  def self.user_sum
    @all_users = User.count
    return @all_users
  end

  def self.total_employ_time
    # @person = User.includes(:release_date, :employment_date)
    # @time_till_employed = User.select("title, instructions").where(user_id: 1).or(Milestone.select("title, instructions").where(user_id: "*"))
    @people = User.all
    @sum = 0
    @people.each do |p|
     @difference = (p.employment_date - p.release_date).to_i
     @sum += @difference
    end
    return @sum
  end

  def self.users_by_location
    all_places = []
    @places = ["Brooklyn", "Bronx", "Queens", "Manhattan", "Staten Island", "Long Island", "Albany", "Rochester", "Syracuse", "Buffalo"]

    @places.each do |place|
      # temp_one = "#{place} "
      # @user_location = User.where(residence: place).count.to_s
      @user_location_num = User.where(residence: place).count
      @percent = (((@user_location_num*100))/(User.user_sum)).round(1)

      temp_one = "#{place}: " + "#{@user_location_num} " + "______#{@percent}" + "%"

      all_places << temp_one
    end

    return all_places
  end

  def self.users_empoyment_status
    all_empoyment_info = []
    @jobs = ["Construction", "Health Care", "Education", "Technology", "Automobile", "Manufacturing", "Customer Service", "Security", "Law", "Public Advocacy",]

    @jobs.each do |jobs|
      @all_employed = User.where(employed: true).count
      # temp_one = "#{place} "
      # @user_job_status = User.where(employment_type: jobs).count.to_s
      @user_job_status = User.where(employment_type: jobs).count
      @percent = (((@user_job_status*100))/(@all_employed)).round(1)

      temp_one = "#{jobs}: " + "#{@user_job_status} " + "______#{@percent}" + "%"

      all_empoyment_info << temp_one
    end
    @full = User.where(work_hours: 'full time').count
    @percent_full = (((@full*100))/(@all_employed)).round(1)

    @part = User.where(work_hours: 'part time').count
    @percent_part = (((@part*100))/(@all_employed)).round(1)

    total = "Total Employed: " + "#{@all_employed}"
    all_empoyment_info << ''
    all_empoyment_info << total
    all_empoyment_info << "Total Full-Time: " + "#{@full}" + "______#{@percent_full}%"
    all_empoyment_info << "Total Part-Time: " + "#{@part}" + "______#{@percent_part}%"

    return  all_empoyment_info
  end
end
