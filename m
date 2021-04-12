Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 49E5A35D2FF
	for <lists+netfilter-devel@lfdr.de>; Tue, 13 Apr 2021 00:23:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241678AbhDLWXf (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Mon, 12 Apr 2021 18:23:35 -0400
Received: from mail.netfilter.org ([217.70.188.207]:50398 "EHLO
        mail.netfilter.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241651AbhDLWXf (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Mon, 12 Apr 2021 18:23:35 -0400
Received: from us.es (unknown [90.77.255.23])
        by mail.netfilter.org (Postfix) with ESMTPSA id EFBC263E3C;
        Tue, 13 Apr 2021 00:22:50 +0200 (CEST)
Date:   Tue, 13 Apr 2021 00:23:13 +0200
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     Florian Westphal <fw@strlen.de>
Cc:     netfilter-devel@vger.kernel.org,
        syzbot+cfc0247ac173f597aaaa@syzkaller.appspotmail.com,
        Andy Nguyen <theflow@google.com>
Subject: Re: [PATCH nf] netfilter: x_tables: fix compat match/target pad
 out-of-bound write
Message-ID: <20210412222313.GA20328@salvia>
References: <20210407193857.21120-1-fw@strlen.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210407193857.21120-1-fw@strlen.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Wed, Apr 07, 2021 at 09:38:57PM +0200, Florian Westphal wrote:
> xt_compat_match/target_from_user doesn't check that zeroing the area
> to start of next rule won't write past end of allocated ruleset blob.
> 
> Remove this code and zero the entire blob beforehand.

Applied.
