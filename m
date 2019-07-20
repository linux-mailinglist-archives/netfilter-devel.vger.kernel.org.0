Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 195946F018
	for <lists+netfilter-devel@lfdr.de>; Sat, 20 Jul 2019 18:52:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726405AbfGTQwG (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Sat, 20 Jul 2019 12:52:06 -0400
Received: from orbyte.nwl.cc ([151.80.46.58]:40986 "EHLO orbyte.nwl.cc"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726221AbfGTQwF (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Sat, 20 Jul 2019 12:52:05 -0400
Received: from n0-1 by orbyte.nwl.cc with local (Exim 4.91)
        (envelope-from <n0-1@orbyte.nwl.cc>)
        id 1hosaa-0005zT-N6; Sat, 20 Jul 2019 18:52:04 +0200
Date:   Sat, 20 Jul 2019 18:52:04 +0200
From:   Phil Sutter <phil@nwl.cc>
To:     Pablo Neira Ayuso <pablo@netfilter.org>
Cc:     netfilter-devel@vger.kernel.org
Subject: Re: [iptables PATCH 03/12] xtables-save: Use argv[0] as program name
Message-ID: <20190720165204.GA22661@orbyte.nwl.cc>
Mail-Followup-To: Phil Sutter <phil@nwl.cc>,
        Pablo Neira Ayuso <pablo@netfilter.org>,
        netfilter-devel@vger.kernel.org
References: <20190720163026.15410-1-phil@nwl.cc>
 <20190720163026.15410-4-phil@nwl.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190720163026.15410-4-phil@nwl.cc>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Sat, Jul 20, 2019 at 06:30:17PM +0200, Phil Sutter wrote:
> Don't hard-code program names. This also fixes for bogus 'xtables-save'
> name which is no longer used.
> 
> Signed-off-by: Phil Sutter <phil@nwl.cc>

Argh, I should have pulled upstream first, this one was already
accepted. My series rebases cleanly, should I respin?

Sorry for the mess. :(
