require 'digest/sha1'
module ContentHelper
  def calc_distributed_class(articles, max_articles, grp_class, min_class, max_class)
    (grp_class.to_prefix rescue grp_class.to_s) +
      ((max_articles == 0) ?
           min_class.to_s :
         (min_class + ((max_class-min_class) * articles.to_f / max_articles).to_i).to_s)
  end

  # Need to rewrite this one, quick hack to test my changes.
  def page_title
    @page_title
  end

  def print_price(p)
    sprintf('%.02f',p)
  end

  include SidebarHelper

  def article_links(article, separator="&nbsp;<strong>|</strong>&nbsp;")
    code = []
    code << category_links(article)   unless article.categories.empty?
    code << tag_links(article)        unless article.tags.empty?
    code << comments_link(article)    if article.allow_comments?
    code << trackbacks_link(article)  if article.allow_pings?
    code.join(separator)
  end

  def category_links(article, prefix="Posted in")
    _(prefix) + " " + article.categories.map { |c| link_to h(c.name), category_url(c), :rel => 'tag'}.join(", ")
  end

  def tag_links(article, prefix="Tags")
    _(prefix) + " " + article.tags.map { |tag| link_to tag.display_name, tag.permalink_url, :rel => "tag"}.sort.join(", ")
  end

  def next_link(article, prefix="")
    n = article.next
    prefix = (prefix.blank?) ? "#{n.title} &raquo;" : prefix
    return  n ? link_to_permalink(n, prefix) : ''
  end

  def prev_link(article, prefix="")
    p = article.previous
    prefix = (prefix.blank?) ? "&laquo; #{p.title}" : prefix
    return p ? link_to_permalink(p, prefix) : ''
  end

  def render_to_string(*args, &block)
    controller.send(:render_to_string, *args, &block)
  end
end
