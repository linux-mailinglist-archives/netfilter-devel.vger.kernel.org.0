Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C4832B7AA3
	for <lists+netfilter-devel@lfdr.de>; Thu, 19 Sep 2019 15:37:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390473AbfISNha (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Thu, 19 Sep 2019 09:37:30 -0400
Received: from mail-ua1-f48.google.com ([209.85.222.48]:34943 "EHLO
        mail-ua1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388819AbfISNha (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Thu, 19 Sep 2019 09:37:30 -0400
Received: by mail-ua1-f48.google.com with SMTP id n63so1069162uan.2
        for <netfilter-devel@vger.kernel.org>; Thu, 19 Sep 2019 06:37:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=yj3QM0kzTMw1Sir6nVXv04xaTLlG+YGx2f4lJPrMaLs=;
        b=RYS4c9IDBSzy++N43a0bPN4GHDYCQ+5KO1Uef1qw924AHifcSWRvsp0BZnMrEkv2dX
         wxxGkXz8WRRZ327BBiu1EoL2QH/FD58EXZRmmffz0HI9zDhbvSS3OhiEtgsKiKxY2HTq
         9k4CMJ4zuj5SDq78nOV2NXuZM4EVtTJPt3xHlTszVAlub82U/EtmkXYy27teVVlOD6vX
         Nk6jCB1y4vQ5NHmUScH+w+6YlTdowsLT73wFT9tphhuJeDiboMkI73D+8w9oHdcpQyNd
         T6z7SMjSa4euhyOtOkBmD9x3siZhcV+HPq7T5SVhnX00KvE6Ee0puEiRkKOPqzTi8I+7
         6vXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=yj3QM0kzTMw1Sir6nVXv04xaTLlG+YGx2f4lJPrMaLs=;
        b=oxC4EUrT3sjWjS1F7zz8dlHAYyCmUhe8nIA1eztZzBHLfeMOI1d9f3psZPucpdYhGl
         HK11fbU4bfHzh+KpxI2SpU/Q4gUzeAHivyrNIruzhzJ1VZAIGxNSFNhBCcj3J9bfSzy5
         oPQTJCjiGOEXDnjuQhKntadfTKcB4w0BHwxuas5/kE5BctrXdVvGiFMUHppfwiFvMe7S
         r1XQL2cWfg4MMuJ5LrMwD2qvtDXsoz9qFZohUjksYLOWQUtZTxynop0EVazIhk5h5kN9
         z+YgkH6p44knpYPBDEg6jXxZpFs88mgoIlFBY1nMpkAzX6WOecQ+Xr6yKyQlizZZ4+N2
         NZ3A==
X-Gm-Message-State: APjAAAWwbqgsy47f/UgOwMfHDHOmWtUHYhNo8/rW3ROXQOj9CI3E0hiq
        xOEaTlp/AEpjWDUjxn2acDpONdeGz7SxGe7xHhPggQ==
X-Google-Smtp-Source: APXvYqwcBjVvYoTbpWg59BMljxb6w2ViSgPElJYppSDKQVgO1+7pqyVDiOmvVhg4Lr7PHA4FgtnRU00wTgoqwFnG6Ck=
X-Received: by 2002:ab0:7256:: with SMTP id d22mr5159325uap.102.1568900249128;
 Thu, 19 Sep 2019 06:37:29 -0700 (PDT)
MIME-Version: 1.0
From:   Wambui Karuga <wambui.dev@gmail.com>
Date:   Thu, 19 Sep 2019 16:37:18 +0300
Message-ID: <CAF0ihpasN+7p8T8xiVt9tnmKUVtBAbF50_hv_E1mspWV+A0dYg@mail.gmail.com>
Subject: Contributing to the Netfilter Project.
To:     netfilter-devel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Hello Netfilter team!

I've been following the work of the Netfilter project for a while now,
and would love to start contributing to any of the software under the
project. I have mainly interacted with the  libmnl, conntrack-tools,
and libnetfilter_conntrack projects, but would be up for starting out
anywhere. Please let me know how I can go about contributing to the
project as a developer!

Thanks!
