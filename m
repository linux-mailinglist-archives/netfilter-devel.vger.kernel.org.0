Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 636747EC103
	for <lists+netfilter-devel@lfdr.de>; Wed, 15 Nov 2023 11:57:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234868AbjKOK5b (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Wed, 15 Nov 2023 05:57:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234098AbjKOK5a (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Wed, 15 Nov 2023 05:57:30 -0500
Received: from ganesha.gnumonks.org (ganesha.gnumonks.org [IPv6:2001:780:45:1d:225:90ff:fe52:c662])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA6F29F
        for <netfilter-devel@vger.kernel.org>; Wed, 15 Nov 2023 02:57:27 -0800 (PST)
Received: from [78.30.43.141] (port=54320 helo=gnumonks.org)
        by ganesha.gnumonks.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <pablo@gnumonks.org>)
        id 1r3DaG-00BTaA-8c
        for netfilter-devel@vger.kernel.org; Wed, 15 Nov 2023 11:57:26 +0100
Date:   Wed, 15 Nov 2023 11:57:23 +0100
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     Netfilter Development <netfilter-devel@vger.kernel.org>
Subject: Re: [PATCH libnetfilter_queue v2 1/1] src: Add nfq_nlmsg_put2() -
 user specifies header flags
Message-ID: <ZVSkE1fzi68CN+uo@calendula>
References: <ZVORoqFJonvQaABS@calendula>
 <20231115100950.6553-1-duncan_roe@optusnet.com.au>
 <ZVScl0WNyKIQlghR@calendula>
 <ZVSjJFXtfhX0WbP3@slk15.local.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZVSjJFXtfhX0WbP3@slk15.local.net>
X-Spam-Score: -1.8 (-)
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Wed, Nov 15, 2023 at 09:53:24PM +1100, Duncan Roe wrote:
> On Wed, Nov 15, 2023 at 11:25:27AM +0100, Pablo Neira Ayuso wrote:
> > On Wed, Nov 15, 2023 at 09:09:50PM +1100, Duncan Roe wrote:
> > > +EXPORT_SYMBOL
> > > +struct nlmsghdr *nfq_nlmsg_put2(char *buf, int type, uint32_t queue_num,
> > > +				uint16_t flags)
> > >  {
> > >  	struct nlmsghdr *nlh = mnl_nlmsg_put_header(buf);
> > >  	nlh->nlmsg_type = (NFNL_SUBSYS_QUEUE << 8) | type;
> > > -	nlh->nlmsg_flags = NLM_F_REQUEST
> > > +	nlh->nlmsg_flags = flags;
> >
> > Leave this as is.
> >
> > NLM_F_REQUEST means this message goes to the kernel, this flag is a
> > must have.
> 
> How about
> 
> 	nlh->nlmsg_flags = NLM_F_REQUEST | flags;

Yes, that is fine.
