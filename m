Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E1E683F5C23
	for <lists+netfilter-devel@lfdr.de>; Tue, 24 Aug 2021 12:29:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236305AbhHXK3b (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Tue, 24 Aug 2021 06:29:31 -0400
Received: from mail.netfilter.org ([217.70.188.207]:43066 "EHLO
        mail.netfilter.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236287AbhHXK3a (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Tue, 24 Aug 2021 06:29:30 -0400
Received: from netfilter.org (unknown [78.30.35.141])
        by mail.netfilter.org (Postfix) with ESMTPSA id F397D600C7;
        Tue, 24 Aug 2021 12:27:51 +0200 (CEST)
Date:   Tue, 24 Aug 2021 12:28:40 +0200
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     Duncan Roe <duncan_roe@optusnet.com.au>
Cc:     netfilter-devel@vger.kernel.org
Subject: Re: [PATCH libnetfilter_queue v4 3/4] build: doc: VPATH builds work
 again
Message-ID: <20210824102840.GA30322@salvia>
References: <20210822041442.8394-1-duncan_roe@optusnet.com.au>
 <20210822041442.8394-3-duncan_roe@optusnet.com.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210822041442.8394-3-duncan_roe@optusnet.com.au>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Sun, Aug 22, 2021 at 02:14:41PM +1000, Duncan Roe wrote:
> Also get make distcleancheck to pass (only applies to VPATH builds).

Not sure I follow. What commit broke this?

Why does this need a separated patch?

> Signed-off-by: Duncan Roe <duncan_roe@optusnet.com.au>
> ---
>  doxygen/Makefile.am | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/doxygen/Makefile.am b/doxygen/Makefile.am
> index 37ed7aa..e788843 100644
> --- a/doxygen/Makefile.am
> +++ b/doxygen/Makefile.am
> @@ -9,7 +9,7 @@ doxyfile.stamp: $(doc_srcs) Makefile.am
>  # If so, sibling src directory will be empty:
>  # move it out of the way and symlink the real one while we run doxygen.
>  	[ -f ../src/Makefile.in ] || \
> -{ set -x; cd ..; mv src src.distcheck; ln -s $(top_srcdir)/src; }
> +{ set -x; cd ..; mv src src.distcheck; ln -s $(abs_top_srcdir)/src; }
>  
>  	cd ..; doxygen doxygen.cfg >/dev/null
>  
> @@ -228,7 +228,7 @@ CLEANFILES = doxyfile.stamp
>  
>  all-local: doxyfile.stamp
>  clean-local:
> -	rm -rf $(top_srcdir)/doxygen/man $(top_srcdir)/doxygen/html
> +	rm -rf man html
>  install-data-local:
>  if BUILD_MAN
>  	mkdir -p $(DESTDIR)$(mandir)/man3
> -- 
> 2.17.5
> 
