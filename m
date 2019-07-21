Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 223C56F2E4
	for <lists+netfilter-devel@lfdr.de>; Sun, 21 Jul 2019 13:29:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726681AbfGUL3Q (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Sun, 21 Jul 2019 07:29:16 -0400
Received: from orbyte.nwl.cc ([151.80.46.58]:42990 "EHLO orbyte.nwl.cc"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726262AbfGUL3Q (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Sun, 21 Jul 2019 07:29:16 -0400
Received: from n0-1 by orbyte.nwl.cc with local (Exim 4.91)
        (envelope-from <n0-1@orbyte.nwl.cc>)
        id 1hpA1h-0006F8-Fn; Sun, 21 Jul 2019 13:29:13 +0200
Date:   Sun, 21 Jul 2019 13:29:13 +0200
From:   Phil Sutter <phil@nwl.cc>
To:     Fernando Fernandez Mancera <ffmancera@riseup.net>
Cc:     Pablo Neira Ayuso <pablo@netfilter.org>,
        netfilter-devel@vger.kernel.org
Subject: Re: [nft PATCH 2/2] nfnl_osf: Silence string truncation gcc warnings
Message-ID: <20190721112913.GF22661@orbyte.nwl.cc>
Mail-Followup-To: Phil Sutter <phil@nwl.cc>,
        Fernando Fernandez Mancera <ffmancera@riseup.net>,
        Pablo Neira Ayuso <pablo@netfilter.org>,
        netfilter-devel@vger.kernel.org
References: <20190720185226.8876-1-phil@nwl.cc>
 <20190720185226.8876-2-phil@nwl.cc>
 <bb559c36-00f3-b295-ed61-6d1ae7d52b58@riseup.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bb559c36-00f3-b295-ed61-6d1ae7d52b58@riseup.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Hi,

On Sun, Jul 21, 2019 at 01:15:58PM +0200, Fernando Fernandez Mancera wrote:
[...]
> >  	pend = nf_osf_strchr(pbeg, OSFPDEL);
> >  	if (pend) {
> >  		*pend = '\0';
> > +		i = sizeof(f.genre);
> >  		if (pbeg[0] == '@' || pbeg[0] == '*')
> > -			cnt = snprintf(f.genre, sizeof(f.genre), "%s", pbeg + 1);
> > -		else
> > -			cnt = snprintf(f.genre, sizeof(f.genre), "%s", pbeg);
> > +			pbeg++;
> > +		cnt = snprintf(f.genre, i, "%.*s", i - 1, pbeg + 1);
> >  		pbeg = pend + 1;
> >  	}
> 
> I am not including this because the pbeg pointer is being modified if
> the condition is true which is not what we want. Note that pbeg is being
> used below. Also, we cannot do pbeg++ and at the same time shift the
> pointer passed to snprintf with pbeg + 1.

Oh, sorry that 'pbeg + 1' in my added code is a bug. I guess
incrementing pbeg if it starts with @ or * is fine because after the
call to snprintf() it is reset ('pbeg = pend + 1') without reusing its
old value.

Cheers, Phil
