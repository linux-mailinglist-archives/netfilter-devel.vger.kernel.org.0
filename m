Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5DC4F3A1DC0
	for <lists+netfilter-devel@lfdr.de>; Wed,  9 Jun 2021 21:34:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229689AbhFITgj (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Wed, 9 Jun 2021 15:36:39 -0400
Received: from mail.netfilter.org ([217.70.188.207]:60074 "EHLO
        mail.netfilter.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229504AbhFITgj (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Wed, 9 Jun 2021 15:36:39 -0400
Received: from netfilter.org (unknown [90.77.255.23])
        by mail.netfilter.org (Postfix) with ESMTPSA id 2FDA36422C;
        Wed,  9 Jun 2021 21:33:30 +0200 (CEST)
Date:   Wed, 9 Jun 2021 21:34:40 +0200
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     Florian Westphal <fw@strlen.de>
Cc:     netfilter-devel@vger.kernel.org, kernel test robot <lkp@intel.com>
Subject: Re: [PATCH v2 nf-next] netfilter: nfnetlink_hook: add depends-on
 nftables
Message-ID: <20210609193440.GA4665@salvia>
References: <20210608205322.8748-1-fw@strlen.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210608205322.8748-1-fw@strlen.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Tue, Jun 08, 2021 at 10:53:22PM +0200, Florian Westphal wrote:
> nfnetlink_hook.c: In function 'nfnl_hook_put_nft_chain_info':
> nfnetlink_hook.c:76:7: error: implicit declaration of 'nft_is_active'
> 
> This macro is only defined when NF_TABLES is enabled.
> While its possible to also add an ifdef-guard, the infrastructure
> is currently not useful without nf_tables.

Applied, thanks.
