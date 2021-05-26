Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 18B21391398
	for <lists+netfilter-devel@lfdr.de>; Wed, 26 May 2021 11:26:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233222AbhEZJ2T (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Wed, 26 May 2021 05:28:19 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:49762 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232218AbhEZJ2T (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Wed, 26 May 2021 05:28:19 -0400
X-Greylist: delayed 338 seconds by postgrey-1.27 at vger.kernel.org; Wed, 26 May 2021 05:28:19 EDT
Received: from imap.suse.de (imap-alt.suse-dmz.suse.de [192.168.254.47])
        by smtp-out1.suse.de (Postfix) with ESMTP id 4BBD4218C1;
        Wed, 26 May 2021 09:21:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1622020870; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=KHa2u/4RvunA8F7SPSfUiKhXKNYHoPJ1ddYB4ghuDYg=;
        b=pOmqTwksoNMzRRLcNE8xKCK1Zlbd4+rZioCwrGgguDxk2JhVLpMeVUZ/QXGs6MyPGEG/F1
        WKczQHOHIUgc3fw39kRstOsuPwnM6Zg/CJEsGP2qvNei6C4mBTN9LHIyE6M2ba9g7UD4G8
        ja2xp369NmpC9PHLdGsjXQS79wJ4R0g=
Received: from director2.suse.de (director2.suse-dmz.suse.de [192.168.254.72])
        by imap.suse.de (Postfix) with ESMTPSA id 23BFF11A98;
        Wed, 26 May 2021 09:21:10 +0000 (UTC)
Date:   Wed, 26 May 2021 11:21:09 +0200
From:   Ali Abdallah <ali.abdallah@suse.com>
To:     Nicolas Dichtel <nicolas.dichtel@6wind.com>
Cc:     netfilter-devel@vger.kernel.org
Subject: Re: [PATCH] Disable RST seq number check when tcp_be_liberal is
 greater 1
Message-ID: <20210526092109.k5potadozmp4kmzj@Fryzen495>
References: <20210521090342.vcuwd7nupytqjwt3@Fryzen495>
 <8fd301da-ff2e-9311-6fc4-4f9c718ea0c8@6wind.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <8fd301da-ff2e-9311-6fc4-4f9c718ea0c8@6wind.com>
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On 24.05.2021 10:39, Nicolas Dichtel wrote:
> >
> > -nf_conntrack_tcp_be_liberal - BOOLEAN
> > +nf_conntrack_tcp_be_liberal - INTEGER
> >  	- 0 - disabled (default)
> > -	- not 0 - enabled
> > +        - 1 - RST sequence number check only
> nit: this line is indented with spaces where other are with tabs.

Yes, will correct that.

Please ignore this patch as I didn't pay attention that tcp_be_liberal
uses proc_dou8vec_minmax (wasn't the case for older releases). Will send
a new patch.

> > +	- greater than 1 - turns off all sequence number/window checks
> Why not having a fixed value (like 2 for example)? It will allow to add
> different behavior in the future.

But then 2 won't disable also other checks?

Anyway, I think a clean solution would be to add another sysctl to
ignore invalid RST.

So please discard this patch.

> Regards,
> Nicolas

Regards,
Ali

