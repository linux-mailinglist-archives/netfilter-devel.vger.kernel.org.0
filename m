Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A07F5EB225
	for <lists+netfilter-devel@lfdr.de>; Thu, 31 Oct 2019 15:08:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726680AbfJaOIC (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Thu, 31 Oct 2019 10:08:02 -0400
Received: from orbyte.nwl.cc ([151.80.46.58]:47298 "EHLO orbyte.nwl.cc"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726506AbfJaOIC (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Thu, 31 Oct 2019 10:08:02 -0400
Received: from n0-1 by orbyte.nwl.cc with local (Exim 4.91)
        (envelope-from <n0-1@orbyte.nwl.cc>)
        id 1iQB7I-0005IO-EU; Thu, 31 Oct 2019 15:08:00 +0100
Date:   Thu, 31 Oct 2019 15:08:00 +0100
From:   Phil Sutter <phil@nwl.cc>
To:     Pablo Neira Ayuso <pablo@netfilter.org>
Cc:     netfilter-devel@vger.kernel.org
Subject: Re: [iptables PATCH v3 07/12] nft: Introduce NFT_CL_SETS cache level
Message-ID: <20191031140800.GD8531@orbyte.nwl.cc>
Mail-Followup-To: Phil Sutter <phil@nwl.cc>,
        Pablo Neira Ayuso <pablo@netfilter.org>,
        netfilter-devel@vger.kernel.org
References: <20191030172701.5892-1-phil@nwl.cc>
 <20191030172701.5892-8-phil@nwl.cc>
 <20191031140425.rtvrbisf2az3gmks@salvia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191031140425.rtvrbisf2az3gmks@salvia>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Thu, Oct 31, 2019 at 03:04:25PM +0100, Pablo Neira Ayuso wrote:
> On Wed, Oct 30, 2019 at 06:26:56PM +0100, Phil Sutter wrote:
> > +static int set_fetch_elem_cb(struct nftnl_set *s, void *data)
> > +{
> > +        char buf[MNL_SOCKET_BUFFER_SIZE];
> > +	struct nft_handle *h = data;
> > +        struct nlmsghdr *nlh;
> > +
> > +	if (set_has_elements(s))
> > +		return 0;
> > +
> > +	nlh = nftnl_nlmsg_build_hdr(buf, NFT_MSG_GETSETELEM, h->family,
> > +				    NLM_F_DUMP, h->seq);
> > +        nftnl_set_elems_nlmsg_build_payload(nlh, s);
> > +
> > +	return mnl_talk(h, nlh, set_elem_cb, s);
> > +}
> 
> Please, mind coding style, irregular indentation.

Oh, thanks for spotting that. Eight spaces are not noticeable in my
editor, maybe I should highlight those.

Thanks, Phil
