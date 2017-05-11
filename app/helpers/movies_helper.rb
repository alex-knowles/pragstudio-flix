module MoviesHelper

  def format_total_gross(movie)
    if movie.flop?
      content_tag(:strong, "Flop!")
    else
      number_to_currency(movie.total_gross)
    end
  end

  def image_for(movie)
    if movie.image_file_name.blank?
      image_tag("placeholder.png")
    else
      image_tag(movie.image_file_name)
    end
  end

  def format_average_stars(movie)
    stars = movie.average_stars
    if stars.nil?
      content_tag(:strong, "No reviews")
    else
      pluralize(number_with_precision(stars, precision: 1), 'star')
    end
  end

  def page_title_for(movie)
    "#{movie.title} (#{movie.released_on.year})"
  end

end
