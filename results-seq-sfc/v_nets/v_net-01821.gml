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
  id 1821
  arrival_time 40295.709745697764
  lifetime 5735.965919478758
  num_nodes 12
  type "path"
  node [
    id 0
    label "0"
    cpu 35
    gpu 32
    rom 35
  ]
  node [
    id 1
    label "1"
    cpu 38
    gpu 49
    rom 45
  ]
  node [
    id 2
    label "2"
    cpu 22
    gpu 33
    rom 20
  ]
  node [
    id 3
    label "3"
    cpu 18
    gpu 33
    rom 3
  ]
  node [
    id 4
    label "4"
    cpu 19
    gpu 31
    rom 1
  ]
  node [
    id 5
    label "5"
    cpu 26
    gpu 13
    rom 42
  ]
  node [
    id 6
    label "6"
    cpu 25
    gpu 9
    rom 11
  ]
  node [
    id 7
    label "7"
    cpu 6
    gpu 18
    rom 16
  ]
  node [
    id 8
    label "8"
    cpu 48
    gpu 23
    rom 21
  ]
  node [
    id 9
    label "9"
    cpu 33
    gpu 13
    rom 10
  ]
  node [
    id 10
    label "10"
    cpu 47
    gpu 11
    rom 26
  ]
  node [
    id 11
    label "11"
    cpu 19
    gpu 6
    rom 7
  ]
  edge [
    source 0
    target 1
    bw 16
  ]
  edge [
    source 1
    target 2
    bw 14
  ]
  edge [
    source 2
    target 3
    bw 41
  ]
  edge [
    source 3
    target 4
    bw 42
  ]
  edge [
    source 4
    target 5
    bw 23
  ]
  edge [
    source 5
    target 6
    bw 1
  ]
  edge [
    source 6
    target 7
    bw 20
  ]
  edge [
    source 7
    target 8
    bw 12
  ]
  edge [
    source 8
    target 9
    bw 32
  ]
  edge [
    source 9
    target 10
    bw 28
  ]
  edge [
    source 10
    target 11
    bw 20
  ]
]
