Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0EB2B557A2E
	for <lists+netfilter-devel@lfdr.de>; Thu, 23 Jun 2022 14:21:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231292AbiFWMVi (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Thu, 23 Jun 2022 08:21:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231230AbiFWMVi (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Thu, 23 Jun 2022 08:21:38 -0400
Received: from orbyte.nwl.cc (orbyte.nwl.cc [IPv6:2001:41d0:e:133a::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8227220D9
        for <netfilter-devel@vger.kernel.org>; Thu, 23 Jun 2022 05:21:36 -0700 (PDT)
Received: from n0-1 by orbyte.nwl.cc with local (Exim 4.94.2)
        (envelope-from <n0-1@orbyte.nwl.cc>)
        id 1o4Lq1-000667-Rv; Thu, 23 Jun 2022 14:21:33 +0200
Date:   Thu, 23 Jun 2022 14:21:33 +0200
From:   Phil Sutter <phil@nwl.cc>
To:     Anton Luka =?utf-8?Q?=C5=A0ijanec?= <anton@sijanec.eu>
Cc:     netfilter-devel@vger.kernel.org
Subject: Re: [PATCH] xtables-monitor: add missing spaces in printed str
Message-ID: <YrRazSi3Dg7grpHY@orbyte.nwl.cc>
Mail-Followup-To: Phil Sutter <phil@nwl.cc>,
        Anton Luka =?utf-8?Q?=C5=A0ijanec?= <anton@sijanec.eu>,
        netfilter-devel@vger.kernel.org
References: <20220622215647.5d996055@varovalka>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220622215647.5d996055@varovalka>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Wed, Jun 22, 2022 at 09:56:47PM +0200, Anton Luka Šijanec wrote:
> when printing the ID and OPTs in iptables/xtables-monitor.c, a space is
> missing after the string, thereby concatenating the number with the next
> item in the printed PACKET line.
> 
> Signed-off-by: Anton Luka Šijanec <anton@sijanec.eu>

Applied after adding Fixes: tag.

Thanks, Phil
