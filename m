Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 498BD7D9948
	for <lists+netfilter-devel@lfdr.de>; Fri, 27 Oct 2023 15:06:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345458AbjJ0NGn (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Fri, 27 Oct 2023 09:06:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231305AbjJ0NGm (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Fri, 27 Oct 2023 09:06:42 -0400
Received: from smtp-bc0a.mail.infomaniak.ch (smtp-bc0a.mail.infomaniak.ch [IPv6:2001:1600:4:17::bc0a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FA38C2
        for <netfilter-devel@vger.kernel.org>; Fri, 27 Oct 2023 06:06:39 -0700 (PDT)
Received: from smtp-3-0000.mail.infomaniak.ch (unknown [10.4.36.107])
        by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4SH2xB0hRRzMrYlt;
        Fri, 27 Oct 2023 13:06:38 +0000 (UTC)
Received: from unknown by smtp-3-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4SH2x93d5Jz3W;
        Fri, 27 Oct 2023 15:06:37 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=digikod.net;
        s=20191114; t=1698411997;
        bh=HsPAU7kFJsQktIBFDD5A3oJhVu7AcVTsWYgBif0Jgno=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jrk9TbrIAf2xa+L+LrodNvyNVaPSTDKge6pv5wboD5TYW+coVvQYpZlwAJv5vK+LA
         hJvjFIYMmrJA/S55O3eBBzOAInOXIbMmksOn5lA9KlIifdUI3fDcolTSsamTWI4X9d
         wKj+3JiN0n4YWWch8Ql+bqFtxHFY7qt1Jev+QnzY=
Date:   Fri, 27 Oct 2023 15:06:34 +0200
From:   =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To:     Konstantin Meskhidze <konstantin.meskhidze@huawei.com>
Cc:     willemdebruijn.kernel@gmail.com, gnoack3000@gmail.com,
        linux-security-module@vger.kernel.org, netdev@vger.kernel.org,
        netfilter-devel@vger.kernel.org, yusongping@huawei.com,
        artem.kuzin@huawei.com, Paul Moore <paul@paul-moore.com>
Subject: Re: [PATCH v14 00/12] Network support for Landlock
Message-ID: <20231027.weic8eidaiQu@digikod.net>
References: <20231026014751.414649-1-konstantin.meskhidze@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231026014751.414649-1-konstantin.meskhidze@huawei.com>
X-Infomaniak-Routing: alpha
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Thanks Konstantin!

I did some minor cosmetic changes, extended a bit the documentation and
improved the ipv4_tcp.with_fs test. You can see these changes in my
-next branch:
https://git.kernel.org/pub/scm/linux/kernel/git/mic/linux.git/log/?h=next

We have a very good test coverage and I think these patches are ready
for mainline.  If it's OK with you, I plan to send a PR for v6.7-rc1 .

Regards,
 Mickaël

On Thu, Oct 26, 2023 at 09:47:39AM +0800, Konstantin Meskhidze wrote:
> Hi,
> This is a new V14 patch related to Landlock LSM network confinement.
> It is based on v6.6-rc2 kernel version.
> 
> It brings refactoring of previous patch version V13.
> Mostly there are fixes of logic and typos, refactoring some selftests.
> 
> All test were run in QEMU evironment and compiled with
>  -static flag.
>  1. network_test: 82/82 tests passed.
>  2. base_test: 7/7 tests passed.
>  3. fs_test: 107/107 tests passed.
>  4. ptrace_test: 8/8 tests passed.
> 
> Previous versions:
> v13: https://lore.kernel.org/linux-security-module/20231016015030.1684504-1-konstantin.meskhidze@huawei.com/
> v12: https://lore.kernel.org/linux-security-module/20230920092641.832134-1-konstantin.meskhidze@huawei.com/
> v11: https://lore.kernel.org/linux-security-module/20230515161339.631577-1-konstantin.meskhidze@huawei.com/
> v10: https://lore.kernel.org/linux-security-module/20230323085226.1432550-1-konstantin.meskhidze@huawei.com/
> v9: https://lore.kernel.org/linux-security-module/20230116085818.165539-1-konstantin.meskhidze@huawei.com/
> v8: https://lore.kernel.org/linux-security-module/20221021152644.155136-1-konstantin.meskhidze@huawei.com/
> v7: https://lore.kernel.org/linux-security-module/20220829170401.834298-1-konstantin.meskhidze@huawei.com/
> v6: https://lore.kernel.org/linux-security-module/20220621082313.3330667-1-konstantin.meskhidze@huawei.com/
> v5: https://lore.kernel.org/linux-security-module/20220516152038.39594-1-konstantin.meskhidze@huawei.com
> v4: https://lore.kernel.org/linux-security-module/20220309134459.6448-1-konstantin.meskhidze@huawei.com/
> v3: https://lore.kernel.org/linux-security-module/20220124080215.265538-1-konstantin.meskhidze@huawei.com/
> v2: https://lore.kernel.org/linux-security-module/20211228115212.703084-1-konstantin.meskhidze@huawei.com/
> v1: https://lore.kernel.org/linux-security-module/20211210072123.386713-1-konstantin.meskhidze@huawei.com/
> 
> Konstantin Meskhidze (11):
>   landlock: Make ruleset's access masks more generic
>   landlock: Refactor landlock_find_rule/insert_rule
>   landlock: Refactor merge/inherit_ruleset functions
>   landlock: Move and rename layer helpers
>   landlock: Refactor layer helpers
>   landlock: Refactor landlock_add_rule() syscall
>   landlock: Add network rules and TCP hooks support
>   selftests/landlock: Share enforce_ruleset()
>   selftests/landlock: Add network tests
>   samples/landlock: Support TCP restrictions
>   landlock: Document network support
> 
> Mickaël Salaün (1):
>   landlock: Allow FS topology changes for domains without such rule type
> 
>  Documentation/userspace-api/landlock.rst     |   96 +-
>  include/uapi/linux/landlock.h                |   55 +
>  samples/landlock/sandboxer.c                 |  115 +-
>  security/landlock/Kconfig                    |    1 +
>  security/landlock/Makefile                   |    2 +
>  security/landlock/fs.c                       |  232 +--
>  security/landlock/limits.h                   |    6 +
>  security/landlock/net.c                      |  198 ++
>  security/landlock/net.h                      |   33 +
>  security/landlock/ruleset.c                  |  405 +++-
>  security/landlock/ruleset.h                  |  183 +-
>  security/landlock/setup.c                    |    2 +
>  security/landlock/syscalls.c                 |  158 +-
>  tools/testing/selftests/landlock/base_test.c |    2 +-
>  tools/testing/selftests/landlock/common.h    |   13 +
>  tools/testing/selftests/landlock/config      |    4 +
>  tools/testing/selftests/landlock/fs_test.c   |   10 -
>  tools/testing/selftests/landlock/net_test.c  | 1744 ++++++++++++++++++
>  18 files changed, 2908 insertions(+), 351 deletions(-)
>  create mode 100644 security/landlock/net.c
>  create mode 100644 security/landlock/net.h
>  create mode 100644 tools/testing/selftests/landlock/net_test.c
> 
> --
> 2.25.1
> 
