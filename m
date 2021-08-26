Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 040193F817F
	for <lists+netfilter-devel@lfdr.de>; Thu, 26 Aug 2021 06:10:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229608AbhHZELG (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Thu, 26 Aug 2021 00:11:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229566AbhHZELG (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Thu, 26 Aug 2021 00:11:06 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C672C061757
        for <netfilter-devel@vger.kernel.org>; Wed, 25 Aug 2021 21:10:19 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id r9so3789611lfn.3
        for <netfilter-devel@vger.kernel.org>; Wed, 25 Aug 2021 21:10:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=qFMFFmUlD4slagt9wQ7be4movbvuF/p9diGkXbO4sYs=;
        b=eTO2uEh/+7hG/g7xe8nNXEob9fS09RqQhDQ0Oy7Kjj1IX80bOim5BE25WaOEip5Mty
         48boN2ltp3ER5b3uAHvWzRC/Jhvnem9kHgi4s+Ya7iHFp2NxUo/VbfC0rDOb45T4Zz5o
         DrrkQqSuSs9uQYerHIrXylCS+ImydErntRJVV+rGrI0b6NrkU0+83E8a0BOWPUdPdkqF
         /2IDJSV/qqh4mZ6Dxfbs/fBDFjL7zr6UGliR2Bx0u0G41YHF9ziVCZMTHApfIZZepUKf
         DUxAd4hOOPgN2y337NokdYYap4UVt5X8nzp0ootlgsXp9tI24aIWnYhLH7vB+pzJI8vz
         Ch3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=qFMFFmUlD4slagt9wQ7be4movbvuF/p9diGkXbO4sYs=;
        b=ib+Vx2rYLabt8yENPvwlw3IMqMhw3OrIE3kGgXWpofX7C+EDh+zFJVsGuoJyhuCaIR
         667xHpcOO/3kOjZTggAQgy3CraPfRLSw6j2O1sHJHmChuCz3Uc04ts/B3o/UB6/nElW1
         TXlM+pfZ5lmEqGMBFTHLJffxnGd5vnmPlFLEZOquEyaOHRE7FjpHzlSwkcNzbq5p8B0Q
         HsfPwB0B5klBD8vHA+QnjmbCNmmgGdmQxS7ObX52VtON4g5JQdlp5yAa34ntnQleHOrj
         yBXHtmeLLRwUpTsHmRb4aIfdPKqrLiaauewbHESuNzTFgQJcVEknAJKWwyBavft8dVzA
         xfWQ==
X-Gm-Message-State: AOAM5331yBGPM/wf1DIVE4oobEheJxyvjawnfaTHTJSygKCYCm8275wb
        +6lzJVj3S2/d+H0uDYnc+82Pjud9zj9t/gtAaH46r/r6/PPyoA==
X-Google-Smtp-Source: ABdhPJwISFcot41rDZTscuIKJFdTrfCjKMIkVkVkhRB5vlEHkqwBjXclZgDbPcQUZfWYdcl9hzKMNozzF+fTRJpbqak=
X-Received: by 2002:a05:6512:2625:: with SMTP id bt37mr1131619lfb.255.1629951017624;
 Wed, 25 Aug 2021 21:10:17 -0700 (PDT)
MIME-Version: 1.0
From:   Tom Yan <tom.ty89@gmail.com>
Date:   Thu, 26 Aug 2021 12:10:05 +0800
Message-ID: <CAGnHSEmo1D2bCemVuCT-D2jdM8AmUgGKxZrq0RpXUMaLyQqjwA@mail.gmail.com>
Subject: [Bug] Reverse translation skips "leading" meta protocol match
To:     netfilter-devel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Hi,

Please see the following for details:

# nft --debug=netlink list table bridge meh
bridge meh hmm 2
  [ meta load l4proto => reg 1 ]
  [ cmp eq reg 1 0x00000011 ]
  [ payload load 2b @ transport header + 2 => reg 1 ]
  [ cmp eq reg 1 0x00004300 ]
  [ immediate reg 0 accept ]

bridge meh hmm 3 2
  [ meta load protocol => reg 1 ]
  [ cmp eq reg 1 0x00000008 ]
  [ meta load l4proto => reg 1 ]
  [ cmp eq reg 1 0x00000011 ]
  [ payload load 2b @ transport header + 2 => reg 1 ]
  [ cmp eq reg 1 0x00004300 ]
  [ immediate reg 0 accept ]

bridge meh hmm 4 3
  [ meta load l4proto => reg 1 ]
  [ cmp eq reg 1 0x00000011 ]
  [ payload load 2b @ transport header + 2 => reg 1 ]
  [ cmp eq reg 1 0x00004300 ]
  [ meta load protocol => reg 1 ]
  [ cmp eq reg 1 0x00000008 ]
  [ immediate reg 0 accept ]

table bridge meh {
    chain hmm {
        udp dport 67 accept
        udp dport 67 accept
        udp dport 67 meta protocol ip accept
    }
}

Regards,
Tom
