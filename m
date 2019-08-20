Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EFBD295FCE
	for <lists+netfilter-devel@lfdr.de>; Tue, 20 Aug 2019 15:18:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729810AbfHTNSl (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Tue, 20 Aug 2019 09:18:41 -0400
Received: from Chamillionaire.breakpoint.cc ([193.142.43.52]:34782 "EHLO
        Chamillionaire.breakpoint.cc" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729409AbfHTNSl (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Tue, 20 Aug 2019 09:18:41 -0400
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
        (envelope-from <fw@strlen.de>)
        id 1i0423-0004sO-TZ; Tue, 20 Aug 2019 15:18:39 +0200
Date:   Tue, 20 Aug 2019 15:18:39 +0200
From:   Florian Westphal <fw@strlen.de>
To:     Michael Braun <michael-dev@fami-braun.de>
Cc:     netfilter-devel@vger.kernel.org
Subject: Re: [PATCHv3] netfilter: nfnetlink_log:add support for VLAN
 information
Message-ID: <20190820131839.GQ2588@breakpoint.cc>
References: <20190820131146.20787-1-michael-dev@fami-braun.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190820131146.20787-1-michael-dev@fami-braun.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Michael Braun <michael-dev@fami-braun.de> wrote:
> Currently, there is no vlan information (e.g. when used with a vlan aware
> bridge) passed to userspache, HWHEADER will contain an 08 00 (ip) suffix
> even for tagged ip packets.
> 
> Therefore, add an extra netlink attribute that passes the vlan information
> to userspace similarly to 15824ab29f for nfqueue.
> 
> Signed-off-by: Michael Braun <michael-dev@fami-braun.de>
> 
> --
> v2: mirror nfqueue behaviour
> v3: remove dep on CONFIG_BRIDGE_NETFILTER, allow NFPROTO_NETDEV, fix size calc

Looks good, thanks for addressing all the comments.

Reviewed-by: Florian Westphal <fw@strlen.de>
