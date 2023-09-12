Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3004379B32C
	for <lists+netfilter-devel@lfdr.de>; Tue, 12 Sep 2023 01:59:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239728AbjIKVhW (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Mon, 11 Sep 2023 17:37:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244163AbjIKTYR (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Mon, 11 Sep 2023 15:24:17 -0400
Received: from ganesha.gnumonks.org (ganesha.gnumonks.org [IPv6:2001:780:45:1d:225:90ff:fe52:c662])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8677110D
        for <netfilter-devel@vger.kernel.org>; Mon, 11 Sep 2023 12:24:12 -0700 (PDT)
Received: from [31.221.198.239] (port=5774 helo=gnumonks.org)
        by ganesha.gnumonks.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <pablo@gnumonks.org>)
        id 1qfmVz-009CzD-Ib; Mon, 11 Sep 2023 21:24:10 +0200
Date:   Mon, 11 Sep 2023 21:24:05 +0200
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     Jeremy Sowden <jeremy@azazel.net>
Cc:     Netfilter Devel <netfilter-devel@vger.kernel.org>
Subject: Re: [PATCH libmnl] nlmsg, attr: fix false positives when validating
 buffer sizes
Message-ID: <ZP9pVfzfv7SYYUM9@calendula>
References: <20230910203018.2782009-1-jeremy@azazel.net>
 <ZP9oyPItYTM2EVuw@calendula>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZP9oyPItYTM2EVuw@calendula>
X-Spam-Score: -1.9 (-)
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Mon, Sep 11, 2023 at 09:21:50PM +0200, Pablo Neira Ayuso wrote:
> On Sun, Sep 10, 2023 at 09:30:18PM +0100, Jeremy Sowden wrote:
> > `mnl_nlmsg_ok` and `mnl_attr_ok` both expect a signed buffer length
> > value, `len`, against which to compare the size of the object expected
> > to fit into the buffer, because they are intended to validate the length
> > and it may be negative in the case of malformed messages.  Comparing
> > this signed value against unsigned operands leads to compiler warnings,
> > so the unsigned operands are cast to `int`.  Comparing `len` to the size
> > of the structure is fine, because the structures are only a few bytes in
> > size.  Comparing it to the length fields of `struct nlmsg` and `struct
> > nlattr`, however, is problematic, since these fields may hold values
> > greater than `INT_MAX`, in which case the casts will yield negative
> > values and result in false positives.
> > 
> > Instead, assign `len` to an unsigned local variable, check for negative
> > values first, then use the unsigned local for the other comparisons, and
> > remove the casts.
> > 
> > Closes: https://bugzilla.netfilter.org/show_bug.cgi?id=1691
> > Signed-off-by: Jeremy Sowden <jeremy@azazel.net>
> > ---
> >  src/attr.c  | 9 +++++++--
> >  src/nlmsg.c | 9 +++++++--
> >  2 files changed, 14 insertions(+), 4 deletions(-)
> > 
> > diff --git a/src/attr.c b/src/attr.c
> > index bc39df4199e7..48e95019d5e8 100644
> > --- a/src/attr.c
> > +++ b/src/attr.c
> > @@ -97,9 +97,14 @@ EXPORT_SYMBOL void *mnl_attr_get_payload(const struct nlattr *attr)
> >   */
> >  EXPORT_SYMBOL bool mnl_attr_ok(const struct nlattr *attr, int len)
> 
> Maybe turn this into uint32_t ?

Actually, attribute length field is 16 bits long, so it can never
happen that nla_len will underflow.
