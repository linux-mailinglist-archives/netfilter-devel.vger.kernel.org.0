Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3188765D6C0
	for <lists+netfilter-devel@lfdr.de>; Wed,  4 Jan 2023 16:02:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229441AbjADPCd (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Wed, 4 Jan 2023 10:02:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239451AbjADPC3 (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Wed, 4 Jan 2023 10:02:29 -0500
Received: from mail.netfilter.org (mail.netfilter.org [217.70.188.207])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 25F03E0EC
        for <netfilter-devel@vger.kernel.org>; Wed,  4 Jan 2023 07:02:28 -0800 (PST)
Date:   Wed, 4 Jan 2023 16:02:24 +0100
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     Sriram Yagnaraman <sriram.yagnaraman@est.tech>
Cc:     netfilter-devel@vger.kernel.org, Florian Westphal <fw@strlen.de>,
        Marcelo Ricardo Leitner <mleitner@redhat.com>,
        Long Xin <lxin@redhat.com>
Subject: Re: [RFC PATCH] netfilter: conntrack: simplify sctp state machine
Message-ID: <Y7WVAEky9Iy3Ri3T@salvia>
References: <20230104113143.21769-1-sriram.yagnaraman@est.tech>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230104113143.21769-1-sriram.yagnaraman@est.tech>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Wed, Jan 04, 2023 at 12:31:43PM +0100, Sriram Yagnaraman wrote:
> All the paths in an SCTP connection are kept alive either by actual
> DATA/SACK running through the connection or by HEARTBEAT. This patch
> proposes a simple state machine with only two states OPEN_WAIT and
> ESTABLISHED (similar to UDP). The reason for this change is a full
> stateful approach to SCTP is difficult when the association is
> multihomed since the endpoints could use different paths in the network
> during the lifetime of an association.

Do you mean the router/firewall might not see all packets for
association is multihomed?

Could you please provide an example?
