Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC266387D0B
	for <lists+netfilter-devel@lfdr.de>; Tue, 18 May 2021 18:02:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344303AbhERQEG (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Tue, 18 May 2021 12:04:06 -0400
Received: from mail.netfilter.org ([217.70.188.207]:43166 "EHLO
        mail.netfilter.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344672AbhERQEF (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Tue, 18 May 2021 12:04:05 -0400
Received: from us.es (unknown [90.77.255.23])
        by mail.netfilter.org (Postfix) with ESMTPSA id 8C17963089;
        Tue, 18 May 2021 18:01:51 +0200 (CEST)
Date:   Tue, 18 May 2021 18:02:42 +0200
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     Florian Westphal <fw@strlen.de>
Cc:     netfilter-devel@vger.kernel.org
Subject: Re: [PATCH nf-next 0/2] nf_tables: avoid retpoline overhead on set
 lookups
Message-ID: <20210518160242.GB24307@salvia>
References: <20210513202956.22709-1-fw@strlen.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210513202956.22709-1-fw@strlen.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Thu, May 13, 2021 at 10:29:54PM +0200, Florian Westphal wrote:
> This adds a nft_set_do_lookup() helper, then extends it to use
> direct calls when RETPOLINE feature is enabled.
> 
> For non-retpoline builds, nft_set_do_lookup() inline helper
> does a indirect call.  INDIRECT_CALLABLE_SCOPE macro allows to
> keep the lookup functions static in this case.

Applied, thanks.
