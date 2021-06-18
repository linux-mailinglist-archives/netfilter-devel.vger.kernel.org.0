Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D6EF3ACB0D
	for <lists+netfilter-devel@lfdr.de>; Fri, 18 Jun 2021 14:34:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230476AbhFRMgh (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Fri, 18 Jun 2021 08:36:37 -0400
Received: from mail.netfilter.org ([217.70.188.207]:50248 "EHLO
        mail.netfilter.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230315AbhFRMgh (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Fri, 18 Jun 2021 08:36:37 -0400
Received: from netfilter.org (unknown [90.77.255.23])
        by mail.netfilter.org (Postfix) with ESMTPSA id B55646425E;
        Fri, 18 Jun 2021 14:33:06 +0200 (CEST)
Date:   Fri, 18 Jun 2021 14:34:25 +0200
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     Florian Westphal <fw@strlen.de>
Cc:     netfilter-devel@vger.kernel.org
Subject: Re: [PATCH nf-next] netfilter: conntrack: pass hook state to log
 functions
Message-ID: <20210618123425.GA9951@salvia>
References: <20210616200619.1506-1-fw@strlen.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210616200619.1506-1-fw@strlen.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Wed, Jun 16, 2021 at 10:06:19PM +0200, Florian Westphal wrote:
> The packet logger backend is unable to provide the incoming (or
> outgoing) interface name because that information isn't available.
> 
> Pass the hook state, it contains the network namespace, the protocol
> family, the network interfaces and other things.

Applied, thanks.
