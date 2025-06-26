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
  id 1702
  arrival_time 37718.97735327666
  lifetime 313.3139479805867
  num_nodes 13
  type "path"
  node [
    id 0
    label "0"
    cpu 12
    gpu 16
    rom 29
  ]
  node [
    id 1
    label "1"
    cpu 32
    gpu 40
    rom 41
  ]
  node [
    id 2
    label "2"
    cpu 29
    gpu 10
    rom 27
  ]
  node [
    id 3
    label "3"
    cpu 16
    gpu 27
    rom 36
  ]
  node [
    id 4
    label "4"
    cpu 8
    gpu 15
    rom 28
  ]
  node [
    id 5
    label "5"
    cpu 3
    gpu 35
    rom 37
  ]
  node [
    id 6
    label "6"
    cpu 7
    gpu 30
    rom 44
  ]
  node [
    id 7
    label "7"
    cpu 24
    gpu 16
    rom 30
  ]
  node [
    id 8
    label "8"
    cpu 41
    gpu 44
    rom 24
  ]
  node [
    id 9
    label "9"
    cpu 48
    gpu 24
    rom 9
  ]
  node [
    id 10
    label "10"
    cpu 17
    gpu 11
    rom 36
  ]
  node [
    id 11
    label "11"
    cpu 17
    gpu 22
    rom 39
  ]
  node [
    id 12
    label "12"
    cpu 1
    gpu 0
    rom 13
  ]
  edge [
    source 0
    target 1
    bw 19
  ]
  edge [
    source 1
    target 2
    bw 30
  ]
  edge [
    source 2
    target 3
    bw 36
  ]
  edge [
    source 3
    target 4
    bw 39
  ]
  edge [
    source 4
    target 5
    bw 37
  ]
  edge [
    source 5
    target 6
    bw 42
  ]
  edge [
    source 6
    target 7
    bw 19
  ]
  edge [
    source 7
    target 8
    bw 43
  ]
  edge [
    source 8
    target 9
    bw 47
  ]
  edge [
    source 9
    target 10
    bw 19
  ]
  edge [
    source 10
    target 11
    bw 24
  ]
  edge [
    source 11
    target 12
    bw 48
  ]
]
