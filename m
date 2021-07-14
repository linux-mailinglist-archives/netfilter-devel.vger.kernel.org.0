Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ACAC13C81AC
	for <lists+netfilter-devel@lfdr.de>; Wed, 14 Jul 2021 11:34:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238773AbhGNJhO (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Wed, 14 Jul 2021 05:37:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238337AbhGNJhO (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Wed, 14 Jul 2021 05:37:14 -0400
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [IPv6:2a0a:51c0:0:12e:520::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A785FC06175F
        for <netfilter-devel@vger.kernel.org>; Wed, 14 Jul 2021 02:34:22 -0700 (PDT)
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
        (envelope-from <fw@strlen.de>)
        id 1m3bHY-0005vD-V4; Wed, 14 Jul 2021 11:34:20 +0200
Date:   Wed, 14 Jul 2021 11:34:20 +0200
From:   Florian Westphal <fw@strlen.de>
To:     Erik Wilson <erik.e.wilson@gmail.com>
Cc:     netfilter-devel@vger.kernel.org
Subject: Re: [PATCH] xtables: Call init_extensions6() for static builds
Message-ID: <20210714093420.GA9904@breakpoint.cc>
References: <20210713234823.36131-1-Erik.E.Wilson@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210713234823.36131-1-Erik.E.Wilson@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Erik Wilson <erik.e.wilson@gmail.com> wrote:
> Initialize extensions from libext6 for cases where xtables is built statically.
> 
> Closes: https://bugzilla.netfilter.org/show_bug.cgi?id=1550
> Signed-off-by: Erik Wilson <Erik.E.Wilson@gmail.com>

Applied, thank you.
