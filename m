Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F2C0432C9EE
	for <lists+netfilter-devel@lfdr.de>; Thu,  4 Mar 2021 02:20:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240479AbhCDBPY (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Wed, 3 Mar 2021 20:15:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346444AbhCDBNf (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Wed, 3 Mar 2021 20:13:35 -0500
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [IPv6:2a0a:51c0:0:12e:520::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 296B7C0613DD
        for <netfilter-devel@vger.kernel.org>; Wed,  3 Mar 2021 17:11:54 -0800 (PST)
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
        (envelope-from <fw@strlen.de>)
        id 1lHcWu-0005RW-Pj; Thu, 04 Mar 2021 02:11:52 +0100
Date:   Thu, 4 Mar 2021 02:11:52 +0100
From:   Florian Westphal <fw@strlen.de>
To:     Ludovic =?iso-8859-15?Q?S=E9n=E9caux?= <linuxludo@free.fr>
Cc:     'Florian Westphal' <fw@strlen.de>,
        'Pablo Neira Ayuso' <pablo@netfilter.org>,
        kadlec@netfilter.org, netfilter-devel@vger.kernel.org,
        coreteam@netfilter.org
Subject: Re: [PATCH] netfilter: Fix GRE over IPv6 with conntrack module
Message-ID: <20210304011152.GG17911@breakpoint.cc>
References: <20210303163322.GA17445@salvia>
 <1709326502.137229418.1614790585426.JavaMail.root@zimbra63-e11.priv.proxad.net>
 <20210303171206.GE17911@breakpoint.cc>
 <00a901d71057$2171bc20$64553460$@free.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <00a901d71057$2171bc20$64553460$@free.fr>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Ludovic Sénécaux <linuxludo@free.fr> wrote:
> Thanks for your feedback.
> 
> So, in this case, can you consider this request ?
> Or do I have to make a new one ?

We won't apply this patch as-is.  Please send a v2
following the guidelines & with the feedback addressed.

Alternatively, I will fix this bug myself sometime next week.
