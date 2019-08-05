Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A4ECE81724
	for <lists+netfilter-devel@lfdr.de>; Mon,  5 Aug 2019 12:35:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727259AbfHEKfS (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Mon, 5 Aug 2019 06:35:18 -0400
Received: from Chamillionaire.breakpoint.cc ([193.142.43.52]:41522 "EHLO
        Chamillionaire.breakpoint.cc" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727230AbfHEKfS (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Mon, 5 Aug 2019 06:35:18 -0400
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.89)
        (envelope-from <fw@strlen.de>)
        id 1huaKi-0001gO-QV; Mon, 05 Aug 2019 12:35:16 +0200
Date:   Mon, 5 Aug 2019 12:35:16 +0200
From:   Florian Westphal <fw@strlen.de>
To:     Michael Braun <michael-dev@fami-braun.de>
Cc:     netfilter-devel@vger.kernel.org
Subject: Re: [PATCH] netfilter: nfnetlink_log:add support for VLAN information
Message-ID: <20190805103516.ctrrelq3zcorhr3n@breakpoint.cc>
References: <20190805072814.14922-1-michael-dev@fami-braun.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190805072814.14922-1-michael-dev@fami-braun.de>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Michael Braun <michael-dev@fami-braun.de> wrote:
> Currently, there is no vlan information (e.g. when used with a vlan aware
> bridge) passed to userspache, HWHEADER will contain an 08 00 (ip) suffix
> even for tagged ip packets.
> 
> Therefore, add an extra netlink attribute that passes the vlan tag to
> userspace. Userspace might need to handle PCP/DEI included in this field.
> 
> Signed-off-by: Michael Braun <michael-dev@fami-braun.de>

nfqueue has nfqnl_put_bridge() helper which will plcae both tci and
proto in a nested attribute, I wonder if we can just re-use that?

(Yes, we need new attributes unfortunately).
