Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE17D63DBEE
	for <lists+netfilter-devel@lfdr.de>; Wed, 30 Nov 2022 18:27:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229661AbiK3R1m (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Wed, 30 Nov 2022 12:27:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229878AbiK3R1k (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Wed, 30 Nov 2022 12:27:40 -0500
Received: from mail.netfilter.org (mail.netfilter.org [217.70.188.207])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2EF9F642E
        for <netfilter-devel@vger.kernel.org>; Wed, 30 Nov 2022 09:27:39 -0800 (PST)
Date:   Wed, 30 Nov 2022 18:27:34 +0100
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     Sriram Yagnaraman <sriram.yagnaraman@est.tech>
Cc:     netfilter-devel@vger.kernel.org, Florian Westphal <fw@strlen.de>,
        claudio.porfiri@ericsson.com
Subject: Re: [PATCH v3] netfilter: conntrack: add sctp DATA_SENT state
Message-ID: <Y4eShs1cQ7V0mk9n@salvia>
References: <20221104171835.1224-1-sriram.yagnaraman@est.tech>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20221104171835.1224-1-sriram.yagnaraman@est.tech>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Fri, Nov 04, 2022 at 06:18:35PM +0100, Sriram Yagnaraman wrote:
> Changes since v2:
> - Abandoned the sctp no_random_port patch from the series
> 
> SCTP conntrack currently assumes that the SCTP endpoints will
> probe secondary paths using HEARTBEAT before sending traffic.
> 
> But, according to RFC 9260, SCTP endpoints can send any traffic
> on any of the confirmed paths after SCTP association is up.
> SCTP endpoints that sends INIT will confirm all peer addresses
> that upper layer configures, and the SCTP endpoint that receives
> COOKIE_ECHO will only confirm the address it sent the INIT_ACK to.
> 
> So, we can have a situation where the INIT sender can start to
> use secondary paths without the need to send HEARTBEAT. This patch
> allows DATA/SACK packets to create new connection tracking entry.
> 
> A new state has been added to indicate that a DATA/SACK chunk has
> been seen in the original direction - SCTP_CONNTRACK_DATA_SENT.
> State transitions mostly follows the HEARTBEAT_SENT, except on
> receiving HEARTBEAT/HEARTBEAT_ACK/DATA/SACK in the reply direction.
> 
> State transitions in original direction:
> - DATA_SENT behaves similar to HEARTBEAT_SENT for all chunks,
>    except that it remains in DATA_SENT on receving HEARTBEAT,
>    HEARTBEAT_ACK/DATA/SACK chunks
> State transitions in reply direction:
> - DATA_SENT behaves similar to HEARTBEAT_SENT for all chunks,
>    except that it moves to HEARTBEAT_ACKED on receiving
>    HEARTBEAT/HEARTBEAT_ACK/DATA/SACK chunks
> 
> Note: This patch still doesn't solve the problem when the SCTP
> endpoint decides to use primary paths for association establishment
> but uses a secondary path for association shutdown. We still have
> to depend on timeout for connections to expire in such a case.

Applied, thanks

One request of mine: Would you send a patch to extend

        Documentation/networking/nf_conntrack-sysctl.rst

to document sctp timeouts?

Thanks.
