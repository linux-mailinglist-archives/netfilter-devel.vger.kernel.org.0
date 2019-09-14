Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E5673B2A76
	for <lists+netfilter-devel@lfdr.de>; Sat, 14 Sep 2019 10:30:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727482AbfINIaW (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Sat, 14 Sep 2019 04:30:22 -0400
Received: from Chamillionaire.breakpoint.cc ([193.142.43.52]:57684 "EHLO
        Chamillionaire.breakpoint.cc" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726841AbfINIaW (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Sat, 14 Sep 2019 04:30:22 -0400
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
        (envelope-from <fw@strlen.de>)
        id 1i93Rl-0007Fg-3s; Sat, 14 Sep 2019 10:30:21 +0200
Date:   Sat, 14 Sep 2019 10:30:21 +0200
From:   Florian Westphal <fw@strlen.de>
To:     Phil Sutter <phil@nwl.cc>
Cc:     Pablo Neira Ayuso <pablo@netfilter.org>,
        netfilter-devel@vger.kernel.org
Subject: Re: [iptables PATCH] iptables-test: Support testing host binaries
Message-ID: <20190914083021.GF10656@breakpoint.cc>
References: <20190914005045.17421-1-phil@nwl.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190914005045.17421-1-phil@nwl.cc>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Phil Sutter <phil@nwl.cc> wrote:
> Introduce --host parameter to run the testsuite against host's binaries
> instead of built ones.

Acked-by: Florian Westphal <fw@strlen.de>
