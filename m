Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D346E5AB417
	for <lists+netfilter-devel@lfdr.de>; Fri,  2 Sep 2022 16:50:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236498AbiIBOuF (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Fri, 2 Sep 2022 10:50:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232681AbiIBOtk (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Fri, 2 Sep 2022 10:49:40 -0400
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24F96303CF;
        Fri,  2 Sep 2022 07:11:45 -0700 (PDT)
Received: from sslproxy01.your-server.de ([78.46.139.224])
        by www62.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92.3)
        (envelope-from <daniel@iogearbox.net>)
        id 1oU7OZ-0001V3-07; Fri, 02 Sep 2022 16:11:43 +0200
Received: from [85.1.206.226] (helo=linux-4.home)
        by sslproxy01.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <daniel@iogearbox.net>)
        id 1oU7OY-000VL0-Ir; Fri, 02 Sep 2022 16:11:42 +0200
Subject: Re: [PATCH bpf-next 0/4] Introduce bpf_ct_set_nat_info kfunc helper
To:     Lorenzo Bianconi <lorenzo@kernel.org>, bpf@vger.kernel.org
Cc:     netdev@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
        davem@davemloft.net, kuba@kernel.org, edumazet@google.com,
        pabeni@redhat.com, pablo@netfilter.org, fw@strlen.de,
        netfilter-devel@vger.kernel.org, lorenzo.bianconi@redhat.com,
        brouer@redhat.com, toke@redhat.com, memxor@gmail.com
References: <cover.1662050126.git.lorenzo@kernel.org>
From:   Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <aec3e8d1-6b80-c344-febe-809bbb0308eb@iogearbox.net>
Date:   Fri, 2 Sep 2022 16:11:41 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <cover.1662050126.git.lorenzo@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.103.6/26646/Fri Sep  2 09:55:25 2022)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On 9/1/22 6:43 PM, Lorenzo Bianconi wrote:
> Introduce bpf_ct_set_nat_info kfunc helper in order to set source and
> destination nat addresses/ports in a new allocated ct entry not inserted
> in the connection tracking table yet.
> Introduce support for per-parameter trusted args.
> 
> Kumar Kartikeya Dwivedi (2):
>    bpf: Add support for per-parameter trusted args
>    selftests/bpf: Extend KF_TRUSTED_ARGS test for __ref annotation
> 
> Lorenzo Bianconi (2):
>    net: netfilter: add bpf_ct_set_nat_info kfunc helper
>    selftests/bpf: add tests for bpf_ct_set_nat_info kfunc
> 
>   Documentation/bpf/kfuncs.rst                  | 18 +++++++
>   kernel/bpf/btf.c                              | 39 ++++++++++-----
>   net/bpf/test_run.c                            |  9 +++-
>   net/netfilter/nf_conntrack_bpf.c              | 49 ++++++++++++++++++-
>   .../testing/selftests/bpf/prog_tests/bpf_nf.c |  2 +
>   .../testing/selftests/bpf/progs/test_bpf_nf.c | 26 +++++++++-
>   tools/testing/selftests/bpf/verifier/calls.c  | 38 +++++++++++---
>   7 files changed, 156 insertions(+), 25 deletions(-)
> 

Looks like this fails BPF CI, ptal:

https://github.com/kernel-patches/bpf/runs/8147936670?check_suite_focus=true

[...]
   All error logs:
   test_bpf_nf_ct:PASS:test_bpf_nf__open_and_load 0 nsec
   test_bpf_nf_ct:PASS:iptables 0 nsec
   test_bpf_nf_ct:PASS:start_server 0 nsec
   connect_to_server:PASS:socket 0 nsec
   connect_to_server:PASS:connect_fd_to_fd 0 nsec
   test_bpf_nf_ct:PASS:connect_to_server 0 nsec
   test_bpf_nf_ct:PASS:accept 0 nsec
   test_bpf_nf_ct:PASS:sockaddr len 0 nsec
   test_bpf_nf_ct:PASS:bpf_prog_test_run 0 nsec
   test_bpf_nf_ct:PASS:Test EINVAL for NULL bpf_tuple 0 nsec
   test_bpf_nf_ct:PASS:Test EINVAL for reserved not set to 0 0 nsec
   test_bpf_nf_ct:PASS:Test EINVAL for netns_id < -1 0 nsec
   test_bpf_nf_ct:PASS:Test EINVAL for len__opts != NF_BPF_CT_OPTS_SZ 0 nsec
   test_bpf_nf_ct:PASS:Test EPROTO for l4proto != TCP or UDP 0 nsec
   test_bpf_nf_ct:PASS:Test ENONET for bad but valid netns_id 0 nsec
   test_bpf_nf_ct:PASS:Test ENOENT for failed lookup 0 nsec
   test_bpf_nf_ct:PASS:Test EAFNOSUPPORT for invalid len__tuple 0 nsec
   test_bpf_nf_ct:PASS:Test for alloc new entry 0 nsec
   test_bpf_nf_ct:PASS:Test for insert new entry 0 nsec
   test_bpf_nf_ct:PASS:Test for successful lookup 0 nsec
   test_bpf_nf_ct:PASS:Test for min ct timeout update 0 nsec
   test_bpf_nf_ct:PASS:Test for max ct timeout update 0 nsec
   test_bpf_nf_ct:PASS:Test for ct status update  0 nsec
   test_bpf_nf_ct:PASS:Test existing connection lookup 0 nsec
   test_bpf_nf_ct:PASS:Test existing connection lookup ctmark 0 nsec
   test_bpf_nf_ct:FAIL:Test for source natting unexpected Test for source natting: actual -22 != expected 0
   test_bpf_nf_ct:FAIL:Test for destination natting unexpected Test for destination natting: actual -22 != expected 0
   #16/1    bpf_nf/xdp-ct:FAIL
   test_bpf_nf_ct:PASS:test_bpf_nf__open_and_load 0 nsec
   test_bpf_nf_ct:PASS:iptables 0 nsec
   test_bpf_nf_ct:PASS:start_server 0 nsec
   connect_to_server:PASS:socket 0 nsec
   connect_to_server:PASS:connect_fd_to_fd 0 nsec
   test_bpf_nf_ct:PASS:connect_to_server 0 nsec
   test_bpf_nf_ct:PASS:accept 0 nsec
   test_bpf_nf_ct:PASS:sockaddr len 0 nsec
   test_bpf_nf_ct:PASS:bpf_prog_test_run 0 nsec
   test_bpf_nf_ct:PASS:Test EINVAL for NULL bpf_tuple 0 nsec
   test_bpf_nf_ct:PASS:Test EINVAL for reserved not set to 0 0 nsec
   test_bpf_nf_ct:PASS:Test EINVAL for netns_id < -1 0 nsec
   test_bpf_nf_ct:PASS:Test EINVAL for len__opts != NF_BPF_CT_OPTS_SZ 0 nsec
   test_bpf_nf_ct:PASS:Test EPROTO for l4proto != TCP or UDP 0 nsec
   test_bpf_nf_ct:PASS:Test ENONET for bad but valid netns_id 0 nsec
   test_bpf_nf_ct:PASS:Test ENOENT for failed lookup 0 nsec
   test_bpf_nf_ct:PASS:Test EAFNOSUPPORT for invalid len__tuple 0 nsec
   test_bpf_nf_ct:PASS:Test for alloc new entry 0 nsec
   test_bpf_nf_ct:PASS:Test for insert new entry 0 nsec
   test_bpf_nf_ct:PASS:Test for successful lookup 0 nsec
   test_bpf_nf_ct:PASS:Test for min ct timeout update 0 nsec
   test_bpf_nf_ct:PASS:Test for max ct timeout update 0 nsec
   test_bpf_nf_ct:PASS:Test for ct status update  0 nsec
   test_bpf_nf_ct:PASS:Test existing connection lookup 0 nsec
   test_bpf_nf_ct:PASS:Test existing connection lookup ctmark 0 nsec
   test_bpf_nf_ct:FAIL:Test for source natting unexpected Test for source natting: actual -22 != expected 0
   test_bpf_nf_ct:FAIL:Test for destination natting unexpected Test for destination natting: actual -22 != expected 0
   #16/2    bpf_nf/tc-bpf-ct:FAIL
   #16      bpf_nf:FAIL
[...]
