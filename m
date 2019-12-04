Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 24EBA112CD3
	for <lists+netfilter-devel@lfdr.de>; Wed,  4 Dec 2019 14:46:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727838AbfLDNqO (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Wed, 4 Dec 2019 08:46:14 -0500
Received: from Chamillionaire.breakpoint.cc ([193.142.43.52]:49586 "EHLO
        Chamillionaire.breakpoint.cc" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727828AbfLDNqO (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Wed, 4 Dec 2019 08:46:14 -0500
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
        (envelope-from <fw@strlen.de>)
        id 1icUyp-0004ep-Ty; Wed, 04 Dec 2019 14:46:11 +0100
Date:   Wed, 4 Dec 2019 14:46:11 +0100
From:   Florian Westphal <fw@strlen.de>
To:     Phil Sutter <phil@nwl.cc>
Cc:     Pablo Neira Ayuso <pablo@netfilter.org>,
        netfilter-devel@vger.kernel.org
Subject: Re: [iptables PATCH] extensions: CLUSTERIP: Mark as deprecated in
 man page
Message-ID: <20191204134611.GU795@breakpoint.cc>
References: <20191204130921.2914-1-phil@nwl.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191204130921.2914-1-phil@nwl.cc>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Phil Sutter <phil@nwl.cc> wrote:
> Kernel even warns if being used, reflect its state in man page, too.

Acked-by: Florian Westphal <fw@strlen.de>
