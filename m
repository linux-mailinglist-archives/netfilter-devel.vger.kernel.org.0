Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2A555D7BBF
	for <lists+netfilter-devel@lfdr.de>; Tue, 15 Oct 2019 18:33:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728826AbfJOQdw (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Tue, 15 Oct 2019 12:33:52 -0400
Received: from correo.us.es ([193.147.175.20]:40318 "EHLO mail.us.es"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728170AbfJOQdv (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Tue, 15 Oct 2019 12:33:51 -0400
Received: from antivirus1-rhel7.int (unknown [192.168.2.11])
        by mail.us.es (Postfix) with ESMTP id 571F9B6C6C
        for <netfilter-devel@vger.kernel.org>; Tue, 15 Oct 2019 18:33:46 +0200 (CEST)
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id 4A9B86DAC5
        for <netfilter-devel@vger.kernel.org>; Tue, 15 Oct 2019 18:33:46 +0200 (CEST)
Received: by antivirus1-rhel7.int (Postfix, from userid 99)
        id 401476DA3A; Tue, 15 Oct 2019 18:33:46 +0200 (CEST)
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on antivirus1-rhel7.int
X-Spam-Level: 
X-Spam-Status: No, score=-108.2 required=7.5 tests=ALL_TRUSTED,BAYES_50,
        SMTPAUTH_US2,URIBL_BLOCKED,USER_IN_WHITELIST autolearn=disabled version=3.4.1
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id 32D68D2B1D;
        Tue, 15 Oct 2019 18:33:44 +0200 (CEST)
Received: from 192.168.1.97 (192.168.1.97)
 by antivirus1-rhel7.int (F-Secure/fsigk_smtp/550/antivirus1-rhel7.int);
 Tue, 15 Oct 2019 18:33:44 +0200 (CEST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/antivirus1-rhel7.int)
Received: from us.es (sys.soleta.eu [212.170.55.40])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: 1984lsi)
        by entrada.int (Postfix) with ESMTPSA id 1138342EE38E;
        Tue, 15 Oct 2019 18:33:44 +0200 (CEST)
Date:   Tue, 15 Oct 2019 18:33:46 +0200
X-SMTPAUTHUS: auth mail.us.es
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     Phil Sutter <phil@nwl.cc>, netfilter-devel@vger.kernel.org
Subject: Re: [libnftnl PATCH 5/6] obj/ct_timeout: Avoid array overrun in
 timeout_parse_attr_data()
Message-ID: <20191015163346.kxbhiht44qgg3hma@salvia>
References: <20191015141658.11325-1-phil@nwl.cc>
 <20191015141658.11325-6-phil@nwl.cc>
 <20191015155716.n5amfyrcs5pe42cd@salvia>
 <20191015162130.GZ12661@orbyte.nwl.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191015162130.GZ12661@orbyte.nwl.cc>
User-Agent: NeoMutt/20170113 (1.7.2)
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Tue, Oct 15, 2019 at 06:21:30PM +0200, Phil Sutter wrote:
> Hi,
> 
> On Tue, Oct 15, 2019 at 05:57:16PM +0200, Pablo Neira Ayuso wrote:
> > On Tue, Oct 15, 2019 at 04:16:57PM +0200, Phil Sutter wrote:
> > > Array 'tb' has only 'attr_max' elements, the loop overstepped its
> > > boundary by one. Copy array_size() macro from include/utils.h in
> > > nftables.git to make sure code does the right thing.
> > > 
> > > Fixes: 0adceeab1597a ("src: add ct timeout support")
> > > Signed-off-by: Phil Sutter <phil@nwl.cc>
> > > ---
> > >  include/utils.h      | 8 ++++++++
> > >  src/obj/ct_timeout.c | 2 +-
> > >  2 files changed, 9 insertions(+), 1 deletion(-)
> > > 
> > > diff --git a/include/utils.h b/include/utils.h
> > > index 3cc659652fe2e..91fbebb1956fd 100644
> > > --- a/include/utils.h
> > > +++ b/include/utils.h
> > > @@ -58,6 +58,14 @@ void __nftnl_assert_attr_exists(uint16_t attr, uint16_t attr_max,
> > >  		ret = remain;				\
> > >  	remain -= ret;					\
> > >  
> > > +
> > > +#define BUILD_BUG_ON_ZERO(e)	(sizeof(char[1 - 2 * !!(e)]) - 1)
> > > +
> > > +#define __must_be_array(a) \
> > > +	BUILD_BUG_ON_ZERO(__builtin_types_compatible_p(typeof(a), typeof(&a[0])))
> > > +
> > > +#define array_size(arr)		(sizeof(arr) / sizeof((arr)[0]) + __must_be_array(arr))
> > > +
> > >  const char *nftnl_family2str(uint32_t family);
> > >  int nftnl_str2family(const char *family);
> > >  
> > > diff --git a/src/obj/ct_timeout.c b/src/obj/ct_timeout.c
> > > index a439432deee18..a09e25ae5d44f 100644
> > > --- a/src/obj/ct_timeout.c
> > > +++ b/src/obj/ct_timeout.c
> > > @@ -134,7 +134,7 @@ timeout_parse_attr_data(struct nftnl_obj *e,
> > >  	if (mnl_attr_parse_nested(nest, parse_timeout_attr_policy_cb, &cnt) < 0)
> > >  		return -1;
> > >  
> > > -	for (i = 1; i <= attr_max; i++) {
> > > +	for (i = 1; i < array_size(tb); i++) {
> > 
> > Are you sure this is correct?
> > 
> > array use NFTNL_CTTIMEOUT_* while tb uses netlink NFTA_* attributes.
> 
> The old code can't be correct. Basically it was:
> 
> | struct nlattr *tb[attr_max];
> [...]
> | for (i = 1; i <= attr_max; i++) {
> |   if (tb[i]) {
> [...]
> 
> So in the last round, it accesses 'tb[attr_max]' which is out of bounds.

I see, thanks for explaining.

> Regarding the question of whether the array is big enough at all, I had
> a look at values in 'timeout_protocol' array struct field values
> 'attr_max': either NFTNL_CTTIMEOUT_TCP_MAX or NFTNL_CTTIMEOUT_UDP_MAX.
> Both are last items in unions so serve only for defining array sizes.
> Without checking differences between NFTNL_CTTIMEOUT_* and respective
> NFTA_* symbols, I'd bet the array is large enough! :)

OK!
