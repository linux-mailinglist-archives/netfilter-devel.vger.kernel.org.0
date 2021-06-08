Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0757939FBA7
	for <lists+netfilter-devel@lfdr.de>; Tue,  8 Jun 2021 18:04:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233837AbhFHQFf (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Tue, 8 Jun 2021 12:05:35 -0400
Received: from mail.netfilter.org ([217.70.188.207]:56804 "EHLO
        mail.netfilter.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233799AbhFHQFV (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Tue, 8 Jun 2021 12:05:21 -0400
Received: from netfilter.org (unknown [90.77.255.23])
        by mail.netfilter.org (Postfix) with ESMTPSA id A64FE64133;
        Tue,  8 Jun 2021 18:02:15 +0200 (CEST)
Date:   Tue, 8 Jun 2021 18:03:25 +0200
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     Florian Westphal <fw@strlen.de>
Cc:     netfilter-devel@vger.kernel.org, kernel test robot <lkp@intel.com>
Subject: Re: [PATCH nf-next] nfilter: nf_hooks: fix build failure with
 NF_TABLES=n
Message-ID: <20210608160325.GA1531@salvia>
References: <202106082146.9TmnLWJk-lkp@intel.com>
 <20210608144237.5813-1-fw@strlen.de>
 <20210608154646.GA983@salvia>
 <20210608155326.GH20020@breakpoint.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210608155326.GH20020@breakpoint.cc>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Tue, Jun 08, 2021 at 05:53:26PM +0200, Florian Westphal wrote:
> Pablo Neira Ayuso <pablo@netfilter.org> wrote:
> > Maybe from Kconfig, select CONFIG_NF_TABLES from NFNETLINK_HOOK to
> > reduce ifdef pollution?
> 
> Why? It doesn't depend on nftables?

From kernelside, yes. But you have to compile userspace nftables to
use this infra, unless there is separated tooling, userspace library
or you code your own netlink userspace code.

Adding the "depends on" might also help signal distros that this
subsystem is useful to be turned on.

The #ifdef is perfectly fine to fix the kbuild robot issue, I was just
thinking if it is probably better a different path when looking at the
whole picture.
