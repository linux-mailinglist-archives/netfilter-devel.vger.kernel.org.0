Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EDFC935B00C
	for <lists+netfilter-devel@lfdr.de>; Sat, 10 Apr 2021 21:17:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234911AbhDJTRj (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Sat, 10 Apr 2021 15:17:39 -0400
Received: from mail.netfilter.org ([217.70.188.207]:44960 "EHLO
        mail.netfilter.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234768AbhDJTRj (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Sat, 10 Apr 2021 15:17:39 -0400
Received: from us.es (unknown [90.77.255.23])
        by mail.netfilter.org (Postfix) with ESMTPSA id 60BF462C0E;
        Sat, 10 Apr 2021 21:17:00 +0200 (CEST)
Date:   Sat, 10 Apr 2021 21:17:20 +0200
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     Florian Westphal <fw@strlen.de>
Cc:     netfilter-devel@vger.kernel.org
Subject: Re: [PATCH nf 0/2] arp,ebtables: add pre_exit hooks for arp/ebtable
 hook unregister
Message-ID: <20210410191720.GB17033@salvia>
References: <20210407194340.21594-1-fw@strlen.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210407194340.21594-1-fw@strlen.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Wed, Apr 07, 2021 at 09:43:38PM +0200, Florian Westphal wrote:
> arptables and ebtables need the same fixup that was added for
> ip/ip6tables: synchronize_rcu() is needed before ruleset can be free'd.
> 
> Add pre_exit hooks for this.

Applied, thanks Florian.
