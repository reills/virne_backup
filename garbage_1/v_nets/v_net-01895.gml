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
  id 1895
  arrival_time 41909.53593082942
  lifetime 2830.113782748092
  num_nodes 15
  type "path"
  node [
    id 0
    label "0"
    cpu 25
    gpu 21
    rom 33
  ]
  node [
    id 1
    label "1"
    cpu 41
    gpu 22
    rom 31
  ]
  node [
    id 2
    label "2"
    cpu 22
    gpu 24
    rom 18
  ]
  node [
    id 3
    label "3"
    cpu 24
    gpu 15
    rom 30
  ]
  node [
    id 4
    label "4"
    cpu 29
    gpu 0
    rom 34
  ]
  node [
    id 5
    label "5"
    cpu 23
    gpu 32
    rom 38
  ]
  node [
    id 6
    label "6"
    cpu 4
    gpu 44
    rom 29
  ]
  node [
    id 7
    label "7"
    cpu 31
    gpu 14
    rom 36
  ]
  node [
    id 8
    label "8"
    cpu 20
    gpu 9
    rom 34
  ]
  node [
    id 9
    label "9"
    cpu 40
    gpu 3
    rom 45
  ]
  node [
    id 10
    label "10"
    cpu 14
    gpu 0
    rom 37
  ]
  node [
    id 11
    label "11"
    cpu 28
    gpu 43
    rom 12
  ]
  node [
    id 12
    label "12"
    cpu 38
    gpu 17
    rom 27
  ]
  node [
    id 13
    label "13"
    cpu 34
    gpu 42
    rom 27
  ]
  node [
    id 14
    label "14"
    cpu 31
    gpu 13
    rom 38
  ]
  edge [
    source 0
    target 1
    bw 1
  ]
  edge [
    source 1
    target 2
    bw 32
  ]
  edge [
    source 2
    target 3
    bw 23
  ]
  edge [
    source 3
    target 4
    bw 42
  ]
  edge [
    source 4
    target 5
    bw 22
  ]
  edge [
    source 5
    target 6
    bw 35
  ]
  edge [
    source 6
    target 7
    bw 16
  ]
  edge [
    source 7
    target 8
    bw 50
  ]
  edge [
    source 8
    target 9
    bw 0
  ]
  edge [
    source 9
    target 10
    bw 33
  ]
  edge [
    source 10
    target 11
    bw 0
  ]
  edge [
    source 11
    target 12
    bw 49
  ]
  edge [
    source 12
    target 13
    bw 31
  ]
  edge [
    source 13
    target 14
    bw 8
  ]
]
