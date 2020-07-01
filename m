Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AFF39210CA4
	for <lists+netfilter-devel@lfdr.de>; Wed,  1 Jul 2020 15:47:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731134AbgGANqs (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Wed, 1 Jul 2020 09:46:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731157AbgGANqs (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Wed, 1 Jul 2020 09:46:48 -0400
Received: from janet.servers.dxld.at (janet.servers.dxld.at [IPv6:2a01:4f8:201:89f4::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE3D5C08C5C1
        for <netfilter-devel@vger.kernel.org>; Wed,  1 Jul 2020 06:46:46 -0700 (PDT)
Received: janet.servers.dxld.at; Wed, 01 Jul 2020 15:46:44 +0200
Date:   Wed, 1 Jul 2020 15:46:41 +0200
From:   Daniel =?iso-8859-1?Q?Gr=F6ber?= <dxld@darkboxed.org>
To:     Pablo Neira Ayuso <pablo@netfilter.org>
Cc:     netfilter-devel@vger.kernel.org
Subject: Re: [libnf_ct PATCH v2 1/9] Handle negative snprintf return values
 properly
Message-ID: <20200701134641.GA2820@Eli.clients.dxld.at>
References: <20200624133005.22046-1-dxld@darkboxed.org>
 <20200701110951.GA1346@salvia>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200701110951.GA1346@salvia>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-score: -0.0
X-Spam-bar: /
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Wed, Jul 01, 2020 at 01:09:51PM +0200, Pablo Neira Ayuso wrote:
> On Wed, Jun 24, 2020 at 03:29:57PM +0200, Daniel Gr�ber wrote:
> > Currently the BUFFER_SIZE macro doesn't take negative 'ret' values into
> > account. A negative return should just be passed through to the caller,
> > snprintf will already have set 'errno' properly.
> 
> Series applied, thanks.

Great, thanks!

> > diff --git a/include/internal/internal.h b/include/internal/internal.h
> > index bb44e12..b1fc670 100644
> > --- a/include/internal/internal.h
> > +++ b/include/internal/internal.h
> > @@ -41,6 +41,8 @@
> >  #endif
> >  
> >  #define BUFFER_SIZE(ret, size, len, offset)		\
> > +	if (ret < 0)					\
> > +		return -1;				\
> 
> Side note: I don't like this hidden branch under a macro. But
> snprintf() == -1 is unlikely to happen and I don't have a better idea
> to deal with this case ATM.

Since there is already another branch in this macro I take it the issue is
the part where we return now, right?

I can see how this is kind of nasty being completely implicit and all, how
about using a label and passing the name to the macro? Something like:

    ret = snprintf(...)
    BUFFER_SIZE_ERR(ret, size, len, offset, err);
    [...]
    err:
        return -1;

--Daniel
