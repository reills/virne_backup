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
  id 1054
  arrival_time 22181.716395492767
  lifetime 129.48728817953344
  num_nodes 11
  type "path"
  node [
    id 0
    label "0"
    cpu 41
    gpu 32
    rom 32
  ]
  node [
    id 1
    label "1"
    cpu 46
    gpu 33
    rom 39
  ]
  node [
    id 2
    label "2"
    cpu 15
    gpu 2
    rom 40
  ]
  node [
    id 3
    label "3"
    cpu 12
    gpu 3
    rom 34
  ]
  node [
    id 4
    label "4"
    cpu 7
    gpu 21
    rom 24
  ]
  node [
    id 5
    label "5"
    cpu 45
    gpu 37
    rom 17
  ]
  node [
    id 6
    label "6"
    cpu 20
    gpu 27
    rom 11
  ]
  node [
    id 7
    label "7"
    cpu 20
    gpu 6
    rom 3
  ]
  node [
    id 8
    label "8"
    cpu 47
    gpu 42
    rom 19
  ]
  node [
    id 9
    label "9"
    cpu 29
    gpu 6
    rom 48
  ]
  node [
    id 10
    label "10"
    cpu 45
    gpu 36
    rom 30
  ]
  edge [
    source 0
    target 1
    bw 24
  ]
  edge [
    source 1
    target 2
    bw 24
  ]
  edge [
    source 2
    target 3
    bw 45
  ]
  edge [
    source 3
    target 4
    bw 37
  ]
  edge [
    source 4
    target 5
    bw 21
  ]
  edge [
    source 5
    target 6
    bw 31
  ]
  edge [
    source 6
    target 7
    bw 13
  ]
  edge [
    source 7
    target 8
    bw 47
  ]
  edge [
    source 8
    target 9
    bw 32
  ]
  edge [
    source 9
    target 10
    bw 21
  ]
]
