Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 92F7F7CACE
	for <lists+netfilter-devel@lfdr.de>; Wed, 31 Jul 2019 19:45:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726908AbfGaRpq (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Wed, 31 Jul 2019 13:45:46 -0400
Received: from orbyte.nwl.cc ([151.80.46.58]:41054 "EHLO orbyte.nwl.cc"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727502AbfGaRpp (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Wed, 31 Jul 2019 13:45:45 -0400
Received: from n0-1 by orbyte.nwl.cc with local (Exim 4.91)
        (envelope-from <n0-1@orbyte.nwl.cc>)
        id 1hssfX-0006ee-PY; Wed, 31 Jul 2019 19:45:43 +0200
Date:   Wed, 31 Jul 2019 19:45:43 +0200
From:   Phil Sutter <phil@nwl.cc>
To:     Pablo Neira Ayuso <pablo@netfilter.org>
Cc:     netfilter-devel@vger.kernel.org
Subject: Re: [iptables PATCH 5/5] xtables-monitor: Add family-specific aliases
Message-ID: <20190731174543.GP14469@orbyte.nwl.cc>
Mail-Followup-To: Phil Sutter <phil@nwl.cc>,
        Pablo Neira Ayuso <pablo@netfilter.org>,
        netfilter-devel@vger.kernel.org
References: <20190731163915.22232-1-phil@nwl.cc>
 <20190731163915.22232-6-phil@nwl.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190731163915.22232-6-phil@nwl.cc>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Wed, Jul 31, 2019 at 06:39:15PM +0200, Phil Sutter wrote:
> Allow for more intuitive xtables-monitor use, e.g. 'ebtables-monitor'
> instead of 'xtables-monitor --bridge'. This needs separate main
> functions to call from xtables-nft-multi.c and in turn allows to
> properly initialize for each family. The latter is required to correctly
> print e.g. rules using ebtables extensions.
> 
> Signed-off-by: Phil Sutter <phil@nwl.cc>

This one needs a v2, I forgot to update iptables/.gitignore.

Sorry, Phil
