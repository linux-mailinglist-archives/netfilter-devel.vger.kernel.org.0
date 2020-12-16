Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E741F2DC81C
	for <lists+netfilter-devel@lfdr.de>; Wed, 16 Dec 2020 22:05:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727036AbgLPVEH (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Wed, 16 Dec 2020 16:04:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727000AbgLPVEH (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Wed, 16 Dec 2020 16:04:07 -0500
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [IPv6:2a0a:51c0:0:12e:520::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF75BC061794
        for <netfilter-devel@vger.kernel.org>; Wed, 16 Dec 2020 13:03:26 -0800 (PST)
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
        (envelope-from <fw@strlen.de>)
        id 1kpdx7-0004AN-O2; Wed, 16 Dec 2020 22:03:17 +0100
Date:   Wed, 16 Dec 2020 22:03:17 +0100
From:   Florian Westphal <fw@strlen.de>
To:     Flavio Leitner <fbl@sysclose.org>
Cc:     yang_y_yi@163.com, ovs-dev@openvswitch.org,
        netfilter-devel@vger.kernel.org
Subject: Re: [ovs-dev] [PATCH] conntrack: fix zone sync issue
Message-ID: <20201216210317.GA23575@breakpoint.cc>
References: <20201019025313.407244-1-yang_y_yi@163.com>
 <20201216202546.GD10866@p50.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201216202546.GD10866@p50.lan>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Flavio Leitner <fbl@sysclose.org> wrote:
> 
> This email has 'To' field pointing to ovs-dev, but the patch
> seems to fix another code other than OVS.
> 
> You might have realized by now, but in case you're still waiting... :)

Thanks for pointing that out, patch has been applied to conntrack-tools
repo.
