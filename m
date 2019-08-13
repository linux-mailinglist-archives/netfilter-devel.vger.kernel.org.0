Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D95CB8BA27
	for <lists+netfilter-devel@lfdr.de>; Tue, 13 Aug 2019 15:29:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728373AbfHMN3B (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Tue, 13 Aug 2019 09:29:01 -0400
Received: from Chamillionaire.breakpoint.cc ([193.142.43.52]:55314 "EHLO
        Chamillionaire.breakpoint.cc" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728346AbfHMN3B (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Tue, 13 Aug 2019 09:29:01 -0400
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.89)
        (envelope-from <fw@strlen.de>)
        id 1hxWrE-0001hG-3t; Tue, 13 Aug 2019 15:29:00 +0200
Date:   Tue, 13 Aug 2019 15:29:00 +0200
From:   Florian Westphal <fw@strlen.de>
To:     Todd Seidelmann <tseidelmann@linode.com>
Cc:     netfilter-devel@vger.kernel.org
Subject: Re: [PATCH nf] netfilter: ebtables: Fix argument order to ADD_COUNTER
Message-ID: <20190813132900.o73rfe3h6vag7pdv@breakpoint.cc>
References: <0330b679-4649-df92-f0d7-a0b5c7dcc87d@linode.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0330b679-4649-df92-f0d7-a0b5c7dcc87d@linode.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Todd Seidelmann <tseidelmann@linode.com> wrote:
> The ordering of arguments to the x_tables ADD_COUNTER macro
> appears to be wrong in ebtables (cf. ip_tables.c, ip6_tables.c,
> and arp_tables.c).
> 
> This causes data corruption in the ebtables userspace tools
> because they get incorrect packet & byte counts from the kernel.

Please resend with a 'Signed-off-by' tag and the
'Fixes:' tag that I provided when I reviewd this patch.

It will help stable maintainers to figure out which trees
need this fix applied.
