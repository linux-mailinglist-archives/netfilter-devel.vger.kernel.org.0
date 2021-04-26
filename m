Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DBB0536B5F2
	for <lists+netfilter-devel@lfdr.de>; Mon, 26 Apr 2021 17:38:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233674AbhDZPjP (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Mon, 26 Apr 2021 11:39:15 -0400
Received: from mail.netfilter.org ([217.70.188.207]:51246 "EHLO
        mail.netfilter.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234126AbhDZPjP (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Mon, 26 Apr 2021 11:39:15 -0400
Received: from us.es (unknown [90.77.255.23])
        by mail.netfilter.org (Postfix) with ESMTPSA id 0F35F63085;
        Mon, 26 Apr 2021 17:37:56 +0200 (CEST)
Date:   Mon, 26 Apr 2021 17:38:29 +0200
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     Florian Westphal <fw@strlen.de>
Cc:     netfilter-devel@vger.kernel.org
Subject: Re: [PATCH nf-next] netfilter: allow to turn off xtables compat layer
Message-ID: <20210426153829.GA2350@salvia>
References: <20210426101440.25335-1-fw@strlen.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210426101440.25335-1-fw@strlen.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Mon, Apr 26, 2021 at 12:14:40PM +0200, Florian Westphal wrote:
> The compat layer needs to parse untrusted input (the ruleset)
> to translate it to a 64bit compatible format.
> 
> We had a number of bugs in this department in the past, so allow users
> to turn this feature off.
> 
> Add CONFIG_NETFILTER_XTABLES_COMPAT kconfig knob and make it default to y
> to keep existing behaviour.

Applied, thanks.
