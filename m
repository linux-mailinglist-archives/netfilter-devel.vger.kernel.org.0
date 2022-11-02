Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F389E616455
	for <lists+netfilter-devel@lfdr.de>; Wed,  2 Nov 2022 15:03:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230522AbiKBODF (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Wed, 2 Nov 2022 10:03:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231234AbiKBOCq (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Wed, 2 Nov 2022 10:02:46 -0400
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [IPv6:2a0a:51c0:0:12e:520::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D53BE0C9
        for <netfilter-devel@vger.kernel.org>; Wed,  2 Nov 2022 07:02:43 -0700 (PDT)
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
        (envelope-from <fw@strlen.de>)
        id 1oqEKH-0003om-J8; Wed, 02 Nov 2022 15:02:41 +0100
Date:   Wed, 2 Nov 2022 15:02:41 +0100
From:   Florian Westphal <fw@strlen.de>
To:     sriram.yagnaraman@est.tech
Cc:     netfilter-devel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] netfilter: conntrack: add sctp DATA_SENT state
Message-ID: <20221102140241.GG5040@breakpoint.cc>
References: <20221030122541.31354-1-sriram.yagnaraman@est.tech>
 <20221030122541.31354-3-sriram.yagnaraman@est.tech>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221030122541.31354-3-sriram.yagnaraman@est.tech>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

sriram.yagnaraman@est.tech <sriram.yagnaraman@est.tech> wrote:
> From: Sriram Yagnaraman <sriram.yagnaraman@est.tech>
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

Looks OK to me.
