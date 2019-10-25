Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8927FE553F
	for <lists+netfilter-devel@lfdr.de>; Fri, 25 Oct 2019 22:36:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727174AbfJYUgu (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Fri, 25 Oct 2019 16:36:50 -0400
Received: from Chamillionaire.breakpoint.cc ([193.142.43.52]:43840 "EHLO
        Chamillionaire.breakpoint.cc" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727008AbfJYUgu (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Fri, 25 Oct 2019 16:36:50 -0400
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
        (envelope-from <fw@strlen.de>)
        id 1iO6KF-00067B-Sz; Fri, 25 Oct 2019 22:36:47 +0200
Date:   Fri, 25 Oct 2019 22:36:47 +0200
From:   Florian Westphal <fw@strlen.de>
To:     Phil Sutter <phil@nwl.cc>
Cc:     Pablo Neira Ayuso <pablo@netfilter.org>,
        netfilter-devel@vger.kernel.org
Subject: Re: [iptables PATCH] xtables-arp: Use xtables_ipparse_multiple()
Message-ID: <20191025203647.GZ25052@breakpoint.cc>
References: <20191025163733.28576-1-phil@nwl.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191025163733.28576-1-phil@nwl.cc>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Phil Sutter <phil@nwl.cc> wrote:
> Use the same code for parsing source and destination IP addresses as
> iptables and drop all the local functions dealing with that.
> 
> While being at it, call free() for 'saddrs' and 'daddrs' unconditionally
> (like iptables does), they are NULL if not used.

Acked-by: Florian Westphal <fw@strlen.de>
