Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 90E5234772E
	for <lists+netfilter-devel@lfdr.de>; Wed, 24 Mar 2021 12:26:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234940AbhCXLZf (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Wed, 24 Mar 2021 07:25:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232820AbhCXLZL (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Wed, 24 Mar 2021 07:25:11 -0400
Received: from mail.netfilter.org (mail.netfilter.org [IPv6:2001:4b98:dc0:41:216:3eff:fe8c:2bda])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A5994C061763
        for <netfilter-devel@vger.kernel.org>; Wed, 24 Mar 2021 04:25:11 -0700 (PDT)
Received: from us.es (unknown [90.77.255.23])
        by mail.netfilter.org (Postfix) with ESMTPSA id 8ECF762BDE;
        Wed, 24 Mar 2021 12:25:02 +0100 (CET)
Date:   Wed, 24 Mar 2021 12:25:08 +0100
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     Mikhail Sennikovsky <mikhail.sennikovskii@cloud.ionos.com>
Cc:     netfilter-devel@vger.kernel.org
Subject: Re: [PATCH v3 4/8] conntrack: introduce ct_cmd_list
Message-ID: <20210324112508.GB30128@salvia>
References: <20210129212452.45352-1-mikhail.sennikovskii@cloud.ionos.com>
 <20210129212452.45352-5-mikhail.sennikovskii@cloud.ionos.com>
 <20210315171731.GA24971@salvia>
 <CALHVEJbgBdW+5M+dxYkbcHU-ML9E444kTPHakSHkqwgFbdrGGg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CALHVEJbgBdW+5M+dxYkbcHU-ML9E444kTPHakSHkqwgFbdrGGg@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Wed, Mar 17, 2021 at 07:28:59PM +0100, Mikhail Sennikovsky wrote:
[...]
> > > +                                             | CT_DELETE       \
> > > +                                             | CT_FLUSH        \
> > > +                                             | EXP_CREATE      \
> > > +                                             | EXP_DELETE      \
> > > +                                             | EXP_FLUSH       \
> >
> > Do you need expectations too? The expectation support for the
> > conntrack command line tool is limited IIRC.
>
> Actually I do not need expectations, and I agree they can be removed for now.

Yes, let's skip expectations until someone has a usecase for this.

Thanks.
