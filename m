Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 16452FDB60
	for <lists+netfilter-devel@lfdr.de>; Fri, 15 Nov 2019 11:29:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727137AbfKOK3K (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Fri, 15 Nov 2019 05:29:10 -0500
Received: from Chamillionaire.breakpoint.cc ([193.142.43.52]:36550 "EHLO
        Chamillionaire.breakpoint.cc" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727122AbfKOK3J (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Fri, 15 Nov 2019 05:29:09 -0500
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
        (envelope-from <fw@strlen.de>)
        id 1iVYqh-0003VX-Qo; Fri, 15 Nov 2019 11:29:07 +0100
Date:   Fri, 15 Nov 2019 11:29:07 +0100
From:   Florian Westphal <fw@strlen.de>
To:     Phil Sutter <phil@nwl.cc>
Cc:     Pablo Neira Ayuso <pablo@netfilter.org>,
        netfilter-devel@vger.kernel.org
Subject: Re: [iptables PATCH 1/2] nft: CMD_ZERO needs a rule cache
Message-ID: <20191115102907.GJ19558@breakpoint.cc>
References: <20191115094725.19756-1-phil@nwl.cc>
 <20191115094725.19756-2-phil@nwl.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191115094725.19756-2-phil@nwl.cc>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Phil Sutter <phil@nwl.cc> wrote:
> In order to zero rule counters, they have to be fetched from kernel. Fix
> this for both standalone calls as well as xtables-restore --noflush.

Reviewed-by: Florian Westphal <fw@strlen.de>
