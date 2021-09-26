Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 191DA4187EC
	for <lists+netfilter-devel@lfdr.de>; Sun, 26 Sep 2021 11:34:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229691AbhIZJgT (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Sun, 26 Sep 2021 05:36:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229584AbhIZJgT (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Sun, 26 Sep 2021 05:36:19 -0400
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [IPv6:2a0a:51c0:0:12e:520::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33F01C061570
        for <netfilter-devel@vger.kernel.org>; Sun, 26 Sep 2021 02:34:43 -0700 (PDT)
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
        (envelope-from <fw@strlen.de>)
        id 1mUQYR-0001J4-MD; Sun, 26 Sep 2021 11:34:39 +0200
Date:   Sun, 26 Sep 2021 11:34:39 +0200
From:   Florian Westphal <fw@strlen.de>
To:     "mizuta.takeshi@fujitsu.com" <mizuta.takeshi@fujitsu.com>
Cc:     "'netfilter-devel@vger.kernel.org'" <netfilter-devel@vger.kernel.org>
Subject: Re: [PATCH iptables] xtables-translate: add missing argument and
 option to usage
Message-ID: <20210926093439.GA2935@breakpoint.cc>
References: <TYAPR01MB4160D345C99412EED8FFF1C38EA29@TYAPR01MB4160.jpnprd01.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <TYAPR01MB4160D345C99412EED8FFF1C38EA29@TYAPR01MB4160.jpnprd01.prod.outlook.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

mizuta.takeshi@fujitsu.com <mizuta.takeshi@fujitsu.com> wrote:
> In xtables-translate usage, the argument <FILE> for the -f option and
> the -V|--version option are missing, so added them.

Applied, thanks.
