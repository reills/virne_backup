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
  id 1226
  arrival_time 25399.86507028294
  lifetime 239.25025387720035
  num_nodes 13
  type "path"
  node [
    id 0
    label "0"
    cpu 28
    gpu 12
    rom 4
  ]
  node [
    id 1
    label "1"
    cpu 45
    gpu 7
    rom 19
  ]
  node [
    id 2
    label "2"
    cpu 37
    gpu 24
    rom 29
  ]
  node [
    id 3
    label "3"
    cpu 10
    gpu 2
    rom 10
  ]
  node [
    id 4
    label "4"
    cpu 12
    gpu 33
    rom 13
  ]
  node [
    id 5
    label "5"
    cpu 7
    gpu 30
    rom 45
  ]
  node [
    id 6
    label "6"
    cpu 19
    gpu 15
    rom 49
  ]
  node [
    id 7
    label "7"
    cpu 25
    gpu 30
    rom 5
  ]
  node [
    id 8
    label "8"
    cpu 17
    gpu 11
    rom 12
  ]
  node [
    id 9
    label "9"
    cpu 43
    gpu 41
    rom 27
  ]
  node [
    id 10
    label "10"
    cpu 47
    gpu 24
    rom 22
  ]
  node [
    id 11
    label "11"
    cpu 10
    gpu 47
    rom 38
  ]
  node [
    id 12
    label "12"
    cpu 42
    gpu 18
    rom 33
  ]
  edge [
    source 0
    target 1
    bw 39
  ]
  edge [
    source 1
    target 2
    bw 13
  ]
  edge [
    source 2
    target 3
    bw 42
  ]
  edge [
    source 3
    target 4
    bw 45
  ]
  edge [
    source 4
    target 5
    bw 8
  ]
  edge [
    source 5
    target 6
    bw 31
  ]
  edge [
    source 6
    target 7
    bw 50
  ]
  edge [
    source 7
    target 8
    bw 13
  ]
  edge [
    source 8
    target 9
    bw 12
  ]
  edge [
    source 9
    target 10
    bw 47
  ]
  edge [
    source 10
    target 11
    bw 19
  ]
  edge [
    source 11
    target 12
    bw 5
  ]
]
