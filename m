Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D1505091EC
	for <lists+netfilter-devel@lfdr.de>; Wed, 20 Apr 2022 23:15:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236984AbiDTVSR (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Wed, 20 Apr 2022 17:18:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230118AbiDTVSQ (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Wed, 20 Apr 2022 17:18:16 -0400
Received: from a3.inai.de (a3.inai.de [IPv6:2a01:4f8:10b:45d8::f5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D3A843ACD
        for <netfilter-devel@vger.kernel.org>; Wed, 20 Apr 2022 14:15:27 -0700 (PDT)
Received: by a3.inai.de (Postfix, from userid 25121)
        id E56AA5870451D; Wed, 20 Apr 2022 23:15:24 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by a3.inai.de (Postfix) with ESMTP id E2E7160C3BF85;
        Wed, 20 Apr 2022 23:15:24 +0200 (CEST)
Date:   Wed, 20 Apr 2022 23:15:24 +0200 (CEST)
From:   Jan Engelhardt <jengelh@inai.de>
To:     Topi Miettinen <toiwoton@gmail.com>
cc:     netfilter-devel@vger.kernel.org
Subject: Re: [PATCH] netfilter: nft_socket: socket expressions for GID &
 UID
In-Reply-To: <20220420185447.10199-1-toiwoton@gmail.com>
Message-ID: <6s7r50n6-r8qs-2295-sq7p-p46qoop97ssn@vanv.qr>
References: <20220420185447.10199-1-toiwoton@gmail.com>
User-Agent: Alpine 2.25 (LSU 592 2021-09-18)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org


On Wednesday 2022-04-20 20:54, Topi Miettinen wrote:

>Add socket expressions for checking GID or UID of the originating
>socket. These work also on input side, unlike meta skuid/skgid.

Why exactly is it that meta skuid does not work?
Because of the skb_to_full_sk() call in nft_meta_get_eval_skugid()?

>+	case NFT_SOCKET_GID:
>+		if (sk_fullsock(sk)) {
>+			struct socket *sock;
>+
>+			sock = sk->sk_socket;
>+			if (sock && sock->file)
>+				*dest = from_kgid_munged(sock_net(sk)->user_ns,
>+							 sock->file->f_cred->fsgid);

The code is quite the same as nft_meta_get_eval_skugid's, save for the BH
locking and skb_to_full_sk. Perhaps nft_socket.c could still call into a
suitably augmented nft_meta_get_eval_skugid function to share code.
