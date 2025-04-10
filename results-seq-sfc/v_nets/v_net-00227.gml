graph [
  node_attrs_setting [
    name "cpu"
    distribution "uniform"
    dtype "int"
    generative 1
    low 0
    high 50
    owner "node"
    type "resource"
  ]
  node_attrs_setting [
    name "gpu"
    distribution "uniform"
    dtype "int"
    generative 1
    low 0
    high 50
    owner "node"
    type "resource"
  ]
  node_attrs_setting [
    name "rom"
    distribution "uniform"
    dtype "int"
    generative 1
    low 0
    high 50
    owner "node"
    type "resource"
  ]
  link_attrs_setting "_networkx_list_start"
  link_attrs_setting [
    name "bw"
    distribution "uniform"
    dtype "int"
    generative 1
    low 0
    high 50
    owner "link"
    type "resource"
  ]
  id 227
  arrival_time 4128.888134778686
  lifetime 399.80763775026674
  num_nodes 14
  type "path"
  node [
    id 0
    label "0"
    cpu 29
    gpu 3
    rom 39
  ]
  node [
    id 1
    label "1"
    cpu 13
    gpu 5
    rom 25
  ]
  node [
    id 2
    label "2"
    cpu 28
    gpu 16
    rom 39
  ]
  node [
    id 3
    label "3"
    cpu 50
    gpu 0
    rom 31
  ]
  node [
    id 4
    label "4"
    cpu 21
    gpu 46
    rom 43
  ]
  node [
    id 5
    label "5"
    cpu 11
    gpu 17
    rom 9
  ]
  node [
    id 6
    label "6"
    cpu 11
    gpu 18
    rom 35
  ]
  node [
    id 7
    label "7"
    cpu 1
    gpu 8
    rom 42
  ]
  node [
    id 8
    label "8"
    cpu 14
    gpu 42
    rom 14
  ]
  node [
    id 9
    label "9"
    cpu 12
    gpu 7
    rom 19
  ]
  node [
    id 10
    label "10"
    cpu 18
    gpu 24
    rom 29
  ]
  node [
    id 11
    label "11"
    cpu 12
    gpu 1
    rom 13
  ]
  node [
    id 12
    label "12"
    cpu 33
    gpu 41
    rom 44
  ]
  node [
    id 13
    label "13"
    cpu 48
    gpu 37
    rom 26
  ]
  edge [
    source 0
    target 1
    bw 34
  ]
  edge [
    source 1
    target 2
    bw 19
  ]
  edge [
    source 2
    target 3
    bw 44
  ]
  edge [
    source 3
    target 4
    bw 10
  ]
  edge [
    source 4
    target 5
    bw 2
  ]
  edge [
    source 5
    target 6
    bw 11
  ]
  edge [
    source 6
    target 7
    bw 39
  ]
  edge [
    source 7
    target 8
    bw 47
  ]
  edge [
    source 8
    target 9
    bw 38
  ]
  edge [
    source 9
    target 10
    bw 31
  ]
  edge [
    source 10
    target 11
    bw 43
  ]
  edge [
    source 11
    target 12
    bw 27
  ]
  edge [
    source 12
    target 13
    bw 19
  ]
]
